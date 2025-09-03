#! /bin/bash

FIRST="$1"    #FILE_TXT
SECOND="$2"   #FASTA_TEMPORARY_FOLDER
THIRD="$3"    #OUTPUT_DIR_GLOBAL
FOURTH="$4"   #POINTFINDER_RESULTS
FIFTH="$5"    #QUAST_TEMPORARY_FOLDER
SIXTH="$6"    #SPECIE LIST
#POINT FINDER RUNNING, RESULTS RENAMING AND MOVING TO POINT FINDER FOLDER

##FILE = ${FIRST}				##/home/izslt/nextflow/file.txt         #{RESFINDER_RESGENE_DB}

mkdir ${FOURTH}


## DUE CICLI WHILE:
## QUELLO PIÙ ESTERNO CICLA SU OGNI CAMPIONE (RIGA DEL FILE DEI CODICI), MENTRE IL SECONDO E' PIÙ INTERNO E PER OGNI CAMPIONE
## EFFETTUA TOT ITERAZIONI DI POINTFINDER PER QUANTE SONO LE SPECIE DI MICORGANISMI LISTATE NEL FILE DELLE SPECIE

while read line;
do

        while read row;
        do

	IN=$(ls ${SECOND}/*scaffolds.fasta | grep -o ${line}_scaff.*fasta)

	python -m resfinder -ifa ${SECOND}/${IN} -o ${SECOND}/${line}_point_results/${row}/. -s ${row} -l 0.6 -t 0.8 -acq -c -db_res ${TEST}/databases/resfinder_db/ -db_point ${TEST}/databases/pointfinder_db/ -db_res_kma ${TEST}/databases/resfinder_db/ -db_point_kma ${TEST}/databases/pointfinder_db/ -b ${BLASTN} -k ${KMA}

		mv ${SECOND}/${line}_point_results/${row}/"PointFinder_results.txt" ${SECOND}/${line}_point_results/${row}/"${line}_${row}_PointFinder_results.txt"
		mv ${SECOND}/${line}_point_results/${row}/"${line}_${row}_PointFinder_results.txt" ${FOURTH}
		rm -r ${SECOND}/${line}_point_results/ ${SECOND}/"report_elenco.txt"

        done < ${SIXTH} #${species_entero.txt}

done < ${FIRST} #${params.codes_file}



#UNIQUE POINT FINDER FILE CREATION, WITH SAMPLE NAME APPENDING FOR EACH ROW

for f in ${FOURTH}/*results*; do awk '{print FILENAME (NF?"\t":"") $0}' ${f}  ;done > ${THIRD}/"pointfinder.txt"


# DELETE FASTA TEMPORARY FOLDER, INCLUDING POINT RESULTS FOLDERS FOR EACH SAMPLE
#rm -r ${SECOND} ${FIFTH}

rm -r ${FIFTH} ${FOURTH}

#LEAVE ALL FILES IN OUTPUT FOLDER, EXCEPT THE HTML ONE ( = multiqc html file) 
cd  ${THIRD}
rm *html
