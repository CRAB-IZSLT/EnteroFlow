///////// INCLUDE operator to call all modules.nf in //////////

include { FASTQC } from "${TEST}/modules/fastqc.nf"
include { FASTP } from "${TEST}/modules/fastp.nf"
include { FASTQC2 } from "${TEST}/modules/fastqc2.nf"
include { MULTIQC } from "${TEST}/modules/multiqc.nf"
include { ASSEMBLY } from "${TEST}/modules/assembly.nf"
include { MOVE_FASTA } from "${TEST}/modules/move_fasta.nf"
include { EDIT_FILE_TXT } from "${TEST}/modules/edit_file.nf"
include { QUAST } from "${TEST}/modules/quast.nf"
include { MASHTREE } from "${TEST}/modules/mashtree.nf"
include { KRAKEN2 } from "${TEST}/modules/kraken2.nf"
include { MLST } from "${TEST}/modules/mlst.nf"
include { RESFINDER } from "${TEST}/modules/resfinder.nf"
include { AMRFINDER } from "${TEST}/modules/amrfinder.nf"
include { PLASMIDFINDER } from "${TEST}/modules/plasmidfinder.nf"
include { VIRULENCEFINDER } from "${TEST}/modules/virulence_finder.nf"
include { POINTFINDER } from "${TEST}/modules/pointfinder.nf"
include { R_VISUAL } from "${TEST}/modules/r_visual.nf"





////////  WORKFLOW DEFINITION, CHANNELS AND RECIPROCAL CONNECTIONS ////////////// 


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

        if ( params.kraken == "yes" ) {

        kraken2_ch = KRAKEN2(trim_ch.collect(flat: false).flatMap(), assembly_ch.collect(flat: false).flatMap())

        }

	quast_ch = QUAST(assembly_ch.collect())   
	
	if ( params.tree == "yes" ) {

	mashtree_ch = MASHTREE(assembly_ch.collect())
	
	}

	mlst_ch = MLST(assembly_ch.collect())

	res_finder_ch = RESFINDER(assembly_ch.collect())

	amrfinder_ch = AMRFINDER(assembly_ch.collect())

        plasmid_finder_ch = PLASMIDFINDER(assembly_ch.collect())

        virulence_finder_ch = VIRULENCEFINDER(assembly_ch.collect())

	point_finder_ch = POINTFINDER(assembly_ch.collect())      
	
	r_visual_ch = R_VISUAL(quast_ch.collect(), mlst_ch.collect(), res_finder_ch.collect(), amrfinder_ch.collect(), plasmid_finder_ch.collect(), virulence_finder_ch.collect(), point_finder_ch.collect())

}

////////// PRINT EXECUTION STATUS, SUCCESS OR ENCOUNTERED ERRORS  ///////////////////////////////////

        workflow.onComplete {
        println "Pipeline completed at: $workflow.complete"
        println "Execution status: ${ workflow.success ? "OK" : "failed" }"

}

	workflow.onError {
        println "Error: Pipeline execution stopped with the following message: ${workflow.errorMessage}"
	println "Detailed error: ${workflow.errorReport}"

}


