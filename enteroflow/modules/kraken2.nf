////////  PROCESSO OPZIONALE KRAKEN2 /////////////



process KRAKEN2 {

        errorStrategy 'ignore'
	publishDir "${TEST}/data/kraken"	

        input:                                            //declaration of input channels
        tuple path(trim_folder), val(key), path(reads)
	path(assembly_folder)


        output:                                           //declaration of expected output channels
        path "${key}_kraken"

        script:
        """
	
	mkdir ${key}_kraken
	
	${KRAKEN} --db ${KRAKEN_DB} --threads ${params.threads} --output - --report ${key}_kraken/"${key}.report" --gzip-compressed ${trim_folder}/*1_trim* ${trim_folder}/*2_trim*

	cp ${key}_kraken/"${key}.report" ${params.all_kraken_outputs_folder}
	
	"""
	

}
