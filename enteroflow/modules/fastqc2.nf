process FASTQC2 {

        errorStrategy 'ignore'
        publishDir "${TEST}/data/fastqc/after"      

        input:                                            //declaration of input channel, zero, uno o più
        tuple path(trim_folder), val(key), path(reads)


        output:                                           //declaration of expected output channel
        path "${key}_results_FINALFASTQC"

        script:
        """

        mkdir ${key}_results_FINALFASTQC

        fastqc  ${trim_folder}/*1_trim* -o ${key}_results_FINALFASTQC -f fastq -q -t ${params.threads}

        """
}
