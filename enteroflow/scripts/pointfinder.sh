#! /bin/bash

FIRST="$1"    #FILE_TXT
SECOND="$2"   #FASTA_TEMPORARY_FOLDER
THIRD="$3"    #OUTPUT_DIR_GLOBAL
FOURTH="$4"   #POINTFINDER_RESULTS
FIFTH="$5"    #QUAST_TEMPORARY_FOLDER
SIXTH="$6"    #SPECIE LIST

# Pointfinder execution, editing and positioning of results in final folder

##FILE = ${FIRST}				##/home/izslt/nextflow/file.txt         #{RESFINDER_RESGENE_DB}

mkdir ${FOURTH}


## Nested while loops:
## the external loop cicles between all samples (using newlines in the sample-list file), while the internal loop cycles through the selected species (species_entero.txt)


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



#UNIQUE POINTFINDER FILE CREATION, WITH SAMPLE NAME APPENDING FOR EACH ROW

for f in ${FOURTH}/*results*; do awk '{print FILENAME (NF?"\t":"") $0}' ${f}  ;done > ${THIRD}/"pointfinder.txt"


# DELETE FASTA TEMPORARY FOLDER, INCLUDING POINT RESULTS FOLDERS FOR EACH SAMPLE (not active)
#rm -r ${SECOND} ${FIFTH}

# DELETE QUAST TEMPORAY FOLDER AND SAMPLE-SPECIFIC POINTFINDER RESULTS FOLDER
rm -r ${FIFTH} ${FOURTH}

#LEAVE ALL FILES IN OUTPUT FOLDER, ONLY REMOVE HTML report ( = multiqc html file) 
cd  ${THIRD}
rm *html
