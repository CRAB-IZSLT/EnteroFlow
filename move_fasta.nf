process MOVE_FASTA {

        input:
        path(spades_folder)

        output:
//      path()                           //  > "quast.tsv"  //-o quast_results //find ${pilon_folder}/* -type f -iname "*.fasta"| // xargs cp ${params.temporary_fasta_dir}
 
        script:
        """
	  
        cp ${spades_folder}/*scaffolds.fasta ${params.temporary_fasta_dir}
             
        """
} 
