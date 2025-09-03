process MLST {

        errorStrategy 'ignore'	
//	publishDir params.outdir
	
	input:
	path oggetti_assembly
	

	output:
	path "mlst_results.txt"                    //mlst_folder/"mlst_results.tsv"     //"mlst_folder/mlst_results.tsv" //      mkdir mlst_folder

	script:
	"""

	mlst  */*scaffolds.fasta > "mlst_results.txt"          
	cp "mlst_results.txt" ${params.outdir}

	""" 
}
