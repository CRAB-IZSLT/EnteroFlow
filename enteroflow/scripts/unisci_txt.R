# renv/activate.R

#renv::activate()

# Carica la libreria openxlsx (assicurati di averla installata con install.packages("openxlsx") se non l'hai già fatto)
if (!requireNamespace("openxlsx", quietly = TRUE)) {
  install.packages("openxlsx")
}
library(openxlsx)
# Estrai gli argomenti dalla linea di comando
args <- commandArgs(trailingOnly = TRUE)

# Verifica se sono stati forniti argomenti sufficienti
 if (length(args) < 2) {
  cat("Usage: Rscript script.R input_directory output_excel \n")
  quit(status = 1)
 }

# Imposta gli argomenti
input_directory <- args[1]
output_excel <- args[2]

# Imposta il percorso della directory contenente i file di testo
txt_files <- list.files(input_directory, pattern = "\\.txt$", full.names = TRUE)

wb <- createWorkbook()

# Aggiungi fogli al libro per ogni file di testo
filter_and_write <- function(txt_file) {
  sheet_name <- tools::file_path_sans_ext(basename(txt_file))
  addWorksheet(wb, sheet_name)
  
  # Leggi il contenuto del file di testo
  content <- read.delim(txt_file, sep = "\t", header = FALSE, stringsAsFactors = FALSE)
  
  # Modifica il contenuto della prima cella della prima colonna solo per il foglio "pointfinder"
  if (sheet_name == "pointfinder") {
    first_cell_content <- "#FILE"
    content[1, 1] <- first_cell_content
  }
  
  # Rimuovi le righe che contengono le parole specificate
  words_to_remove <- c("Mutation", "PMID")
  header <- content[1, , drop = FALSE]
  content <- rbind(header, content[-1, , drop = FALSE][
    apply(content[-1, , drop = FALSE], 1, function(row) all(!(words_to_remove %in% row))), , drop = FALSE])
  
  # Scrivi il contenuto nel foglio Excel
  writeData(wb, sheet = sheet_name, x = data.frame(content), startCol = 1, startRow = 1, colNames = FALSE, sep = "\t")
  
  cat(paste("File '", sheet_name, "' filtrato e scritto in Excel.\n"))
}

# Applica la funzione filter_and_write per ogni file di testo 
for (txt_file in txt_files) {
  filter_and_write(txt_file)
}

# Sovrascrivi il libro Excel se esiste già
if (file.exists(output_excel)) {
  unlink(output_excel)
}

# Salva il libro Excel
saveWorkbook(wb, output_excel)
cat(paste("File Excel '", output_excel, "' creato con successo.\n"))

