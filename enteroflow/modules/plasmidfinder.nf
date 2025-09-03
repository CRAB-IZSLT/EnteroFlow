process PLASMIDFINDER {

        errorStrategy 'ignore'
//      publishDir params.outdir

        input:
        path oggetti_assembly

        output:
        path "plasmidfinder_results.txt"                //abricate_folder/    //"abricate_folder/abricate_results.tsv" //      mkdir abricate_folder
	
	script:
        if( params.update_db == "yes" )         
                """
                abricate-get_db --db plasmidfinder --force
                abricate --db plasmidfinder --minid 90 --mincov 60 */*scaffolds.fasta > "plasmidfinder_results.txt"
		cp "plasmidfinder_results.txt" ${params.outdir}		
	              
		"""

        else if( params.update_db == "no" )
                """
                abricate --db plasmidfinder --minid 90 --mincov 60 */*scaffolds.fasta > "plasmidfinder_results.txt"
		cp "plasmidfinder_results.txt" ${params.outdir}                

		"""
}
