process FASTQC {

	errorStrategy 'ignore'
	publishDir '/home/izslt/nextflow/test_nextflow/data/fastqc/before'	

	input:                             //declaration of input channel, zero, uno o più
	tuple val(key), path(reads)

	
	output:				 //declaration of expected output channel
	path "${key}_results"

	script:
	"""
	
	mkdir ${key}_results

	fastqc  ${reads} -o ${key}_results -f fastq -q -t ${params.threads}

	"""
}
