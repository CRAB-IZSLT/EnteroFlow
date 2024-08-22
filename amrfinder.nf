process AMRFINDER {

	errorStrategy 'ignore'	

	input:
	path oggetti_assembly

        output:
        path "AMRfinder_results.txt"

	script:
	if( params.update_db == "si" )
		"""
		amrfinder -U
		
		bash /home/izslt/nextflow/test_nextflow/amrfinder_loop2.sh ${params.codes_file} ${params.temporary_fasta_dir} ${params.threads} ${params.outdir} ${params.amrfinder_results_dir}
		
		echo "AMRfinder terminated" > "AMRfinder_results.txt"
	
		"""

        else if( params.update_db == "no" )
                """
                bash /home/izslt/nextflow/test_nextflow/amrfinder_loop2.sh ${params.codes_file} ${params.temporary_fasta_dir} ${params.threads} ${params.outdir} ${params.amrfinder_results_dir}

		echo "AMRfinder terminated" > "AMRfinder_results.txt"
                
		"""
}
