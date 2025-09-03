process RESFINDER {

        errorStrategy 'ignore'
//	publishDir params.outdir
        
	input:
        path oggetti_assembly

        output:
        path "resfinder_results.txt"                //abricate_folder/    //"abricate_folder/abricate_results.tsv" //      mkdir abricate_folder

        script:
        if( params.update_db == "yes" )
                """
                abricate-get_db --db resfinder --force
                abricate --db resfinder --minid 90 --mincov 60 */*scaffolds.fasta > "resfinder_results.txt"
		cp "resfinder_results.txt" ${params.outdir} 
					
                """

        else if(params.update_db == "no" )
                """
                abricate --db resfinder --minid 90 --mincov 60 */*scaffolds.fasta > "resfinder_results.txt"
		cp "resfinder_results.txt" ${params.outdir}

                """

}
