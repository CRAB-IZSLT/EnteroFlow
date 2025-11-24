#! /bin/bash

FIRST="$1"    #FILE_TXT
SECOND="$2"   #FASTA_TEMPORARY_FOLDER
THIRD="$3"    #THREADS
FOURTH="$4"   #OUTPUT_DIR_GLOBAL
FIFTH="$5"    #AMRFINDER_RESULTS


# Cicles AMRfinder command for every assembled genome. 
# The if...else condition ensures that the output directory(AMRfinder_temporary_results) is created only if not already present,
# granting the resumability of the pipeline via the -resume parameter.


# Updating amrfinder's database

amrfinder -U



if [ ! -d ${FIFTH} ]
then
	mkdir ${FIFTH}

	while read line;
	do
        	IN=$(ls ${SECOND}/*scaffolds.fasta | grep -o ${line}_scaff.*fasta)

        	amrfinder --nucleotide ${SECOND}/${IN} --ident_min 0.9 --coverage_min 0.6 --threads ${THIRD} > ${FIFTH}/"amrfinder_${line}_results.txt"

	done < ${FIRST}

else
        if [ -d ${FIFTH} ]
        	then
                        while read line;
			do
        			IN=$(ls ${SECOND}/*scaffolds.fasta | grep -o ${line}_scaff.*fasta)

        			amrfinder --nucleotide ${SECOND}/${IN} --ident_min 0.9 --coverage_min 0.6 --threads ${THIRD} > ${FIFTH}/"amrfinder_${line}_results.txt"

			done < ${FIRST}
        fi
fi


# Merging results in a single .txt file

for f in ${FIFTH}/*results*; do awk '{print FILENAME (NF?"\t":"") $0}' ${f}  ;done > ${FOURTH}/"amrfinder.txt"

rm -r ${FIFTH}
