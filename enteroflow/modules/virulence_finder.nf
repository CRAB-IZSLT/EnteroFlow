process VIRULENCEFINDER {

        errorStrategy 'ignore'
//      publishDir params.outdir

        input:
        path oggetti_assembly

        output:
        path "virulencefinder_results.txt"                //abricate_folder/    //"abricate_folder/abricate_results.tsv" //      mkdir abricate_folder

        script:
        if( params.update_db == "yes" )
                """
                abricate-get_db --db vfdb --force
                abricate --db vfdb --minid 90 --mincov 60 */*scaffolds.fasta > "virulencefinder_results.txt"
		cp "virulencefinder_results.txt" ${params.outdir}

                """

        else if( params.update_db == "no" )
                """
                abricate --db vfdb --minid 90 --mincov 60 */*scaffolds.fasta > "virulencefinder_results.txt"
		cp "virulencefinder_results.txt" ${params.outdir}
                
		"""
}
