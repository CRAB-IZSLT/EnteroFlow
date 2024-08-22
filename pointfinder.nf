process POINTFINDER {

        input:
        path oggetti_assembly

        output:
        path "pointfinder_results.txt"               

        script:
	if( params.update_db == "si" )		
		"""
		bash /home/izslt/nextflow/test_nextflow/update_databases.sh
	
		bash /home/izslt/nextflow/test_nextflow/bash_24.sh ${params.codes_file} ${params.temporary_fasta_dir} ${params.outdir} ${params.point_results_dir} ${params.temporary_quast_dir} ${params.species_list_entero}
		
		echo "HO AGGIORNATO I DATABASES DI RESFINDER, POINTFINDER E DISINFINDER" > /home/izslt/nextflow/test_nextflow/"REPORT_DATABASES.txt"
		
		echo "Pointfinder terminated" > "pointfinder_results.txt"
			        
		"""

	else if( params.update_db == "no" )
		"""
		bash /home/izslt/nextflow/test_nextflow/bash_24.sh ${params.codes_file} ${params.temporary_fasta_dir} ${params.outdir} ${params.point_results_dir} ${params.temporary_quast_dir} ${params.species_list_entero}

                echo "Pointfinder terminated" > "pointfinder_results.txt"

	
		"""
	
}
