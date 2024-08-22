process R_VISUAL {

        input:
	path(oggetti_quast)
	path(oggetti_mlst)
	path(oggetti_resfinder)
	path(oggetti_amrfinder)
	path(oggetti_plasmidfinder)
	path(oggetti_virulencefinder)
	path(oggetti_pointfinder)        

        output:
//							///home/utente/Genomica/esercizi_Nextflow/data/annotation      

        script:
        """
	
	Rscript /home/izslt/nextflow/test_nextflow/unisci_txt.R ${params.outdir} ${params.outdir}/monitoraggio.xlsx       

        """
} 
