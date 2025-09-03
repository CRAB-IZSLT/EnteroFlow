# Script di kraken che sarà opzionale e su richiesta dello user come parametro da riga di comando
# insieme al comando principale > nextflow run etc. <
# Lo user dovrà in quel caso ovviamente avere come prerequisiti fondamentali
# SIA l'applicativo KRAKEN SIA il DATABASE d kraken installato in un path specifico


# Le variabili temporanee ${KRAKEN} e ${KRAKEN_DB} sostituiranno rispettivamente
# > /home/biouser/bin/kraken2-2.1.3/kraken2 < e > /home/biouser/storage/DB/k2_pluspfp_20240605 <

R1="$1"   ## INPUT TRIMMED R1
R2="$2"   ## INPUT TRIMMED R2
KEY="$3"  ## KEY
OUTPUT="$4" ## OUTPUT FOLDER
ALL_KRAKEN="$5" ##ALL_KRAKEN_REPORT_FOLDER
THREADS="$6"

${KRAKEN} --db ${KRAKEN_DB} --threads ${THREADS} --output - --report ${OUTPUT}/"${KEY}.report" --gzip-compressed ${R1} ${R2}

cp ${OUTPUT}/"${KEY}.report" ${ALL_KRAKEN} #copiamo il report kraken di ogni campione all'interno della cartella universale kraken
