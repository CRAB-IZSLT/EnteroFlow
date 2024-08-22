process QUAST {
	
        input:
	path(oggetti_assembly)

        output:
	path "quast_results.txt"                           

        script:
        """
 
	quast.py */*scaffolds.fasta -o ${params.temporary_quast_dir} --threads ${params.threads} --fast                  
	
	cp ${params.temporary_quast_dir}/"transposed_report.tsv" ${params.outdir}/"quast_transposed_report.txt"
        
	echo "Quast terminated" > "quast_results.txt"
	

	"""
}
