# renv/activate.R

#renv::activate()

# Loads openxlsx library which MUST BE INSTALLED by user with intall.packages("openxlsx") command.
if (!requireNamespace("openxlsx", quietly = TRUE)) {
  install.packages("openxlsx")
}
library(openxlsx)

# Extacts parameters from command line
args <- commandArgs(trailingOnly = TRUE)

# Checks if the correct parameters have been provided
 if (length(args) < 2) {
  cat("Usage: Rscript script.R input_directory output_excel \n")
  quit(status = 1)
 }

# Sets args
input_directory <- args[1]
output_excel <- args[2]

# Sets the filepath for the directory containing the input .txt files
txt_files <- list.files(input_directory, pattern = "\\.txt$", full.names = TRUE)

wb <- createWorkbook()

# Adds a new sheet to the excel book for every input file 
filter_and_write <- function(txt_file) {
  sheet_name <- tools::file_path_sans_ext(basename(txt_file))
  addWorksheet(wb, sheet_name)

  # Reads input .txt file content
  content <- read.delim(txt_file, sep = "\t", header = FALSE, stringsAsFactors = FALSE)

  # Modifies the content of the first cell in first column, only for pointfinder results
  if (sheet_name == "pointfinder") {
    first_cell_content <- "#FILE"
    content[1, 1] <- first_cell_content
  }

  # Removes lines containing the following ids
  words_to_remove <- c("Mutation", "PMID")
  header <- content[1, , drop = FALSE]
  content <- rbind(header, content[-1, , drop = FALSE][
    apply(content[-1, , drop = FALSE], 1, function(row) all(!(words_to_remove %in% row))), , drop = FALSE])

  # Writes the results' content in the excel file
  writeData(wb, sheet = sheet_name, x = data.frame(content), startCol = 1, startRow = 1, colNames = FALSE, sep = "\t")
  
  cat(paste("File '", sheet_name, "' filtrato e scritto in Excel.\n"))
}

# Applies filter_and_write function for every .txt file
for (txt_file in txt_files) {
  filter_and_write(txt_file)
}

# Overwrites Excel file if already present
if (file.exists(output_excel)) {
  unlink(output_excel)
}

# Saves Excel Book to specified directory
saveWorkbook(wb, output_excel)
cat(paste("File Excel '", output_excel, "' creato con successo.\n"))

