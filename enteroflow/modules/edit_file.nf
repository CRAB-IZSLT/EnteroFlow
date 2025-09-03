process EDIT_FILE_TXT {

        publishDir params.temporary_fasta_dir
	publishDir params.all_kraken_outputs_folder	

        input:
        tuple val(key), path(reads)

        output:
        path("report_elenco.txt")                           //  > "quast.tsv"  //-o quast_results

        script:
        """

        echo "${key}" >> ${params.codes_file}
	echo "\n" > ${params.assembly_failures_file}
	echo "\n" > ${params.assembly_failures_file}
	echo "Qui saranno elencati i files che falliranno o meno la fase di assemblaggio" > ${params.assembly_failures_file}
	echo "elenco ok" > "report_elenco.txt"	
        """
}
