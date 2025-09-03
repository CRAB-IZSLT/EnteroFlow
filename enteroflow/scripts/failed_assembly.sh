#!/bin/bash

LOG_ASSEMBLY="$1"
CODICE_CAMPIONE="$2"
FAILURES_FILE="$3"

# File di log generato da Spades
#log_file="./spades.log"

# File dove verranno salvati i campioni falliti
#output_file="./campioni_falliti.txt"

# Cerca "finished abnormally" nel file di log e salva il risultato in una variabile
failed_samples=$(grep "finished abnormally" $LOG_ASSEMBLY)          #$log_file)

# Controlla se la variabile contiene qualcosa
if [ -n "$failed_samples" ]; then
    # Se ci sono campioni falliti, li salva nel file di output
    echo "Campione con assemblaggio fallito: ${CODICE_CAMPIONE} salvato:" >> ${FAILURES_FILE}      #$output_file
    echo "$failed_samples" >> ${FAILURES_FILE} #$output_file
    echo "\n" >> ${FAILURES_FILE} #$output_file
    echo "\n" >> ${FAILURES_FILE} #$output_file
    echo "\n" >> ${FAILURES_FILE} #$output_file
else
    # Se non ci sono campioni falliti, non fare nulla
    echo "\n" >> ${FAILURES_FILE}
    echo "\n" >> ${FAILURES_FILE}
    echo "Nessun assemblaggio fallito trovato: ${CODICE_CAMPIONE} prosegue normalmente l'analisi !" >> ${FAILURES_FILE}
    echo "\n" >> ${FAILURES_FILE} #$output_file
    echo "\n" >> ${FAILURES_FILE} #$output_file
    echo "\n" >> ${FAILURES_FILE} #$output_file
fi

