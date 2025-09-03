process ASSEMBLY {

	errorStrategy 'ignore'	
	publishDir "${TEST}/data/spades"
	
	input:
	tuple path(reads_trim_folder), val(key), path(reads)
	
	output:
	path("${key}_assembly")
	
	script:
	"""
	mkdir ${key}_assembly

	spades.py -t ${params.threads} --isolate --pe1-1 ${reads_trim_folder}/*1_trim* --pe1-2 ${reads_trim_folder}/*2_trim* -o ${key}_assembly

        if [ ! -f ${key}_assembly/scaffolds.fasta ]
        then
                bash "${TEST}"/scripts/failed_assembly.sh ${key}_assembly/spades.log ${key} ${params.assembly_failures_file}
                echo "tutto ok" > "assemblaggio finito male.txt"

        else
                if [ -f ${key}_assembly/scaffolds.fasta ]
                then
                        mv ${key}_assembly/scaffolds.fasta ${key}_assembly/${key}_scaffolds.fasta
                        bash "${TEST}"/scripts/failed_assembly.sh ${key}_assembly/spades.log ${key} ${params.assembly_failures_file}
                fi
        fi

	"""
}
