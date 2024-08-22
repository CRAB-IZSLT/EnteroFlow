process EDIT_FILE_TXT {

        publishDir params.temporary_fasta_dir

        input:
        tuple val(key), path(reads)

        output:
        path("report_elenco.txt")                           //  > "quast.tsv"  //-o quast_results

        script:
        """

        echo "${key}" >> ${params.codes_file}
	echo "elenco ok" > "report_elenco.txt"	
        """
}
