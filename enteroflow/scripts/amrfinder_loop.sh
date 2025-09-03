#! /bin/bash

FIRST="$1"    #FILE_TXT
SECOND="$2"   #FASTA_TEMPORARY_FOLDER
THIRD="$3"    #THREADS
FOURTH="$4"   #OUTPUT_DIR_GLOBAL
FIFTH="$5"    #AMRFINDER_RESULTS


#fare ciclo con amrfinder per ogni genoma assemblato#
#la condizione if..else crea o non crea la cartella AMRfinder_temporary_results#
#questo nel caso dovessimo rilanciare la pipeline con opzione -resume e Nextflow vedesse che già esiste la cartella#
#dando quindi errore#


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


#creare unico file

for f in ${FIFTH}/*results*; do awk '{print FILENAME (NF?"\t":"") $0}' ${f}  ;done > ${FOURTH}/"amrfinder.txt"

rm -r ${FIFTH}
