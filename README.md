<div align="center">
  <img src="https://github.com/CRAB-IZSLT/EnteroFlow/blob/main/Enteroflowchart(1).png" alt="Project Logo" width="700" />
</div>

### _**EnteroFlow** is an automated pipeline for the _in silico_ characterization of <ins>_**Enterococcus faecium/faecalis**_</ins> isolates, developed in [Nextflow](https://www.nextflow.io/) to automate and execute an in-depth characterization starting from [Illumina](http://www.illumina.com/) Paired End short reads. It has been designed for the “end-to-end” analysis of such isolates, efficiently coordinating raw data collection, quality control, de-novo assembly, sequence-typing, and genomic characterization tools for virulence and AMR (Antimicrobic Resistance) detection._
<br/>
<br/>


# 📁 Folder Structure
The pipeline's main directory [enteroflow](enteroflow/) is organized into five subfolders:

1. **CONDA**  
   Contains `.txt` and `.yaml` files for creating specific Conda environments.

2. **CONFIGS**  
   Includes the Nextflow configuration file, parameter files, visualization settings, and a `.txt` file listing microbial species.  
  

3. **DATABASES**  
   Stores the databases for **PointFinder**, **ResFinder**, and **DisinFinder**, which can be optionally updated during pipeline execution.

4. **MODULES**  
   Contains all Nextflow modules (individual scripts and bioinformatics tools) that are called within the main script `entero.nf`, located in the `SCRIPTS` folder.

5. **SCRIPTS**  
   Includes the main workflow script `entero.nf`, which orchestrates the entire pipeline by linking all modules.  
   Also contains necessary `.sh` and `.R` scripts used throughout the workflow.
<br/>
<br/>


# 🛠️ Initial Setup
## 📦 User Requirements

To run Enteroflow, users must be familiar with command line interfaces and have the following tools pre-installed on their operating system:

- [Nextflow](https://www.nextflow.io/) 
- [Conda](https://github.com/conda/conda/releases/tag/25.1.1) **⚠️ version 25.1.1 or previous**  
  (due to deprecated commands in latest versions)
- [Java](https://www.oracle.com/java/technologies/downloads/)  
- [R](https://www.r-project.org/)  
- [BLAST](https://doi.org/10.1016/s0022-2836(05)80360-2)  
- [KMA](https://doi.org/10.1186/s12859-018-2336-6)  

## 1. [Download or clone](https://docs.github.com/en/get-started/start-your-journey/downloading-files-from-github) this repository in your selected local directory.<br/>
```bash
git clone  https://github.com/CRAB-IZSLT/EnteroFlow.git
```

## 2. Set environment variables:<br/>
### Required Environment Variables

Before running, the following 5 environment variables **MUST** be exported:  
_(must be set by the user for every new bash session or permanently added to the `.bashrc` file in your `$HOME` directory for all future sessions)_

```bash
export TEST="/path/to/your/chosen/workflow/directory/"
export BLASTN="/path/to/executable/blastn"
export KMA="/path/to/executable/kma"
export KMA_INDEX="/path/to/executable/kma_index"
export READS="path/to/stored/reads"
```

### Optional Environment Variables

```bash
export KRAKEN="/path/to/executable/kraken"
export KRAKEN_DB="/path/to/kraken/database"
```

By default, the **Mashtree** and **Kraken** modules are disabled: Enteroflow runs with `--tree "no"` and `--kraken "no"` parameters if not specified.<br/>
To enable them, the 2 optional environment variables must be exported beforehand<br/>

<br/>

## 3. Launch the main script from inside the chosen directory.<br/>
 
⚠️ Upon initial use of **Enteroflow**, users **MUST** set the `--update_db` parameter to `"yes"` to download the required databases. ⚠️ <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*(This becomes optional for subsequent runs, updating databases only when requested)*
<br/>

:rocket: Sample startup command: 
```bash
$NEXTFLOW run scripts/entero.nf --threads 16 --update_db "yes" -c configs/nextflow.config --tree "no" --kraken "no" -bg`
```
**note** that <ins>Enteroflow-specific parameters</ins> are set with a double hyphen (like --tree or --threads) while generic <ins>Nextflow-parameters</ins> use a single hyphen (like -bg enables background running)
<br/>
<br/>


# 📥 INPUT:  
🧬 Paired-end Illumina reads of _**E. faecium/faecalis**_ isolates in FASTQ format `(.fastq / .fastq.gz)` are the <ins>__ONLY__</ins> required input.


# 📤 OUTPUT:

📁 **ALL Results** are stored inside the `/data` folder created in the working directory ```($TEST environment variable)```.

📊 Information regarding **quality controls** and filtering of raw reads is stored inside the `/data/fastp` and `data/multiqc` subdirectories.

🧫 Results of the genotyping and molecular characterization processes are saved in the `/data/annotation` subdirectory and summarized in a single comprehensive excel file by a custom R script.  
These include information on **quality of assembly**, **Multilocus Sequence Typing (MLST)**, accessory resistance genes identified using **ResFinder and AmrFinder** databases, specific point mutations involved in AMR identified using **PointFinder**, plasmid replicons from **PlasmidFinder** and virulence genes identified using the **VFDB**.  
🧾 The **excel workbook** is organized in six different sheets named after the corresponding tools, containing results from all analysed isolates at once. This approach is intended to facilitate accessibility and interpretability of results, even for users who are not familiar with command-line interfaces.  

📄 The `elenco_codici_campioni.txt` file, contains a list of all samples included in the current run. _(overwritten by new runs)_

## ⚠️ Important Notes

- The only folders containing actual files (not as symlinks) are `/data/annotation`,`fasta_temporary` and `all_kraken_folder`.  
  Other files (e.g., trimmed reads, MultiQC reports) are stored in the **`/work`** directory and accessed via symlinks.  
  **❗Ensure all necessary files have been saved before deleting the `/work` folder.❗**  
  *this behaviour may be overridden with the `-process.stageOutMode copy` option when launching Enteroflow*




# Who we are

**The National Reference Laboratory for Antimicrobial Resistance (NRL-AR)** in Italy, based at IZSLT in Rome, has made significant efforts in recent years to plan, monitor, and report on antimicrobial resistance in the veterinary sector. Operating from a One Health perspective, the laboratory supports both animal health and veterinary public health.

The NRL-AR operates in collaboration with a national network which includes the Veterinary Public Institutes Network (IIZZSS – all Italian Experimental Institutes for Animal Disease Prevention), the National Reference Laboratories for zoonotic bacterial agents, and the Istituto Superiore di Sanità (National Institute of Health).

On an international level, the laboratory is part of a broader network that focuses on harmonizing analytical methods and interpreting monitoring data. These efforts contribute to public health initiatives in Italy and support the European Commission's objectives across EU Member States.

**Istituto Zooprofilattico Sperimentale del Lazio e della Toscana "M. Aleandri"  Rome**
https://www.izslt.it/



**Dedicated funding for EnteroFlow**: NextGeneration EU-MUR PNRR Extended Partnership Initiative on Emerging Infectious Diseases (Project no. PE00000007, INF-ACT, PE13 INF-ACT, Node 4 and Node 3).​
