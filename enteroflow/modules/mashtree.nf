process MASHTREE {

        errorStrategy 'ignore'
        publishDir "${TEST}/data/mashtree"

        input:
        path oggetti_assembly


        output:
        path "matrice_di_distanza.tsv" 
	path "tree.dnd"

        script:
        """

	mash triangle -p ${params.threads} -s 5000 */*scaffolds.fasta > "matrice_di_distanza.tsv"

	mashtree --numcpus ${params.threads} */*scaffolds.fasta > "tree.dnd"
	
        """
}
