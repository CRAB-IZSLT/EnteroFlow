include { FASTQC } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/fastqc.nf'
include { FASTP } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/fastp.nf'
include { FASTQC2 } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/fastqc2.nf'
include { MULTIQC } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/multiqc.nf'
include { ASSEMBLY } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/assembly.nf'
include { MOVE_FASTA } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/move_fasta.nf'
include { EDIT_FILE_TXT } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/edit_file.nf'
include { QUAST } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/quast.nf'
include { MLST } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/mlst.nf'
include { RESFINDER } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/resfinder.nf'
include { AMRFINDER } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/amrfinder.nf'
include { PLASMIDFINDER } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/plasmidfinder.nf'
include { VIRULENCEFINDER } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/virulence_finder.nf'
include { POINTFINDER } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/pointfinder.nf'
include { R_VISUAL } from '/home/izslt/nextflow/test_nextflow/copia_modulare/modules/r_visual.nf'



workflow {	
	Channel
	.fromFilePairs(params.reads)
	.set {couple_ch}

	fastqc_ch = FASTQC(couple_ch)

	trim_ch = FASTP(couple_ch)

        fastqc2_ch = FASTQC2(trim_ch.collect(flat: false).flatMap())

        multiqc_ch = MULTIQC(fastqc2_ch.collect())

	assembly_ch = ASSEMBLY(trim_ch.collect(flat: false).flatMap()) 

	move_fasta_ch = MOVE_FASTA(assembly_ch)

	edit_file_txt_ch = EDIT_FILE_TXT(couple_ch)

	quast_ch = QUAST(assembly_ch.collect())   

	mlst_ch = MLST(assembly_ch.collect())

	res_finder_ch = RESFINDER(assembly_ch.collect())

	amrfinder_ch = AMRFINDER(assembly_ch.collect())

        plasmid_finder_ch = PLASMIDFINDER(assembly_ch.collect())

        virulence_finder_ch = VIRULENCEFINDER(assembly_ch.collect())

	point_finder_ch = POINTFINDER(assembly_ch.collect())      
	
	r_visual_ch = R_VISUAL(quast_ch.collect(), mlst_ch.collect(), res_finder_ch.collect(), amrfinder_ch.collect(), plasmid_finder_ch.collect(), virulence_finder_ch.collect(), point_finder_ch.collect())

}


        workflow.onComplete {
        println "Pipeline completed at: $workflow.complete"
        println "Execution status: ${ workflow.success ? 'OK' : 'failed' }"
}

