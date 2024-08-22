process FASTP {

        errorStrategy 'ignore'
	publishDir '/home/izslt/nextflow/test_nextflow/data/fastp'
	cache 'deep'

        input:                             //declaration of input channel, zero, uno o più
        tuple val(key), path(reads)


        output:                          //declaration of expected output channel
	tuple path("${key}_trimm"), val(key), path(reads)

        script:
        """

        mkdir ${key}_trimm

	fastp --in1 ${reads[0]} --in2 ${reads[1]} --out1 ${key}_trimm/"${key}_forward_paired.fq.gz" --out2  ${key}_trimm/"${key}_reverse_paired.fq.gz" --thread ${params.threads} -q 25 

        """
}
