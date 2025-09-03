process AMRFINDER {

	errorStrategy 'ignore'	

	input:
	path oggetti_assembly

        output:
        path "AMRfinder_results.txt"

	script:
	if( params.update_db == "yes" )
		"""
		
		bash "${TEST}"/scripts/amrfinder_loop_update.sh ${params.codes_file} ${params.temporary_fasta_dir} ${params.threads} ${params.outdir} ${params.amrfinder_results_dir}
		
		echo "AMRfinder terminated" > "AMRfinder_results.txt"
	
		"""

        else if( params.update_db == "no" )
                """
                bash "${TEST}"/scripts/amrfinder_loop.sh ${params.codes_file} ${params.temporary_fasta_dir} ${params.threads} ${params.outdir} ${params.amrfinder_results_dir}

		echo "AMRfinder terminated" > "AMRfinder_results.txt"
                
		"""
}
