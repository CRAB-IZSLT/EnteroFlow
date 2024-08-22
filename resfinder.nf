process RESFINDER {

	publishDir params.outdir
        
	input:
        path oggetti_assembly

        output:
        path "resfinder_results.txt"                //abricate_folder/    //"abricate_folder/abricate_results.tsv" //      mkdir abricate_folder

        script:
        if( params.update_db == "si" )
                """
                abricate-get_db --db resfinder --force
                abricate --db resfinder --minid 90 --mincov 60 */*scaffolds.fasta > "resfinder_results.txt"

                """

        else if(params.update_db == "no" )
                """
                abricate --db resfinder --minid 90 --mincov 60 */*scaffolds.fasta > "resfinder_results.txt"

                """

}
