process MULTIQC {

        errorStrategy 'ignore'
        publishDir "${TEST}/data/multiqc"
        publishDir params.outdir        

        input:
        path oggetti_fastqc2

        output:
        path "report_03_24_final.html"

        script:
        """
        multiqc .  -n "report_03_24_final.html"

        """
}
