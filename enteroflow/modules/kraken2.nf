////////  PROCESSO OPZIONALE KRAKEN2 /////////////



process KRAKEN2 {

        errorStrategy 'ignore'
	publishDir "${TEST}/data/kraken"	

        input:                                            //declaration of input channel, zero, uno o più
        tuple path(trim_folder), val(key), path(reads)
	path(assembly_folder)


        output:                                           //declaration of expected output channel
        path "${key}_kraken"

        script:
        """
	
	mkdir ${key}_kraken
	
	${KRAKEN} --db ${KRAKEN_DB} --threads ${params.threads} --output - --report ${key}_kraken/"${key}.report" --gzip-compressed ${trim_folder}/*1_trim* ${trim_folder}/*2_trim*

	cp ${key}_kraken/"${key}.report" ${params.all_kraken_outputs_folder}
	
	"""
	
	//"${TEST}"/scripts/kraken2.sh ${trim_folder}/*1_trim* ${trim_folder}/*2_trim* ${key} ${key}_kraken ${params.all_kraken_outputs_folder} ${params.threads}

	//${params.all_kraken_outputs_folder}

}
