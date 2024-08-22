process ASSEMBLY {
	
	publishDir '/home/izslt/nextflow/test_nextflow/data/spades'
	
	input:
	tuple path(reads_trim_folder), val(key), path(reads)
	
	output:
	path("${key}_assembly")
	
	script:
	"""
	mkdir ${key}_assembly

	spades.py -t ${params.threads} --isolate --pe1-1 ${reads_trim_folder}/*forward_paired* --pe1-2 ${reads_trim_folder}/*reverse_paired* -o ${key}_assembly

	mv ${key}_assembly/scaffolds.fasta ${key}_assembly/${key}_scaffolds.fasta

	"""
}
