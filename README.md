![Project Logo](https://github.com/CRAB-IZSLT/EnteroFlow/blob/main/Slide1.jpg)

# EnteroFlow

NextFlow pipeline 

# Purpose

Enteroflow is a bioinformatics workflow designed to automate and execute an in-Depth characterization of E. faecium/faecalis from short read sequencing. 
It has been thought for the “end-to-end” analysis of raw data, by efficiently coordinating raw data collection, quality control, de-novo assembly, sequence-typing, and genomic characterization tools for virulence and AMR (Antimicrobic Resistance) detection.
Specifically, it features mining for antibiotic resistance genes and replicons, virulence factors, resistance associated point mutations, as well as the Multi-locus Sequence Typing for each isolate.

Finally, Enteroflow provides the specialized user through an interactive report which gives an overview of the genomic results and facilitates the reporting phase.

# Quick installation

The pipeline in built using Nextflow, which can be used on any POSIX compatible system (Linux, OS X, etc). Windows system is supported through WSL.
Main folders such “Conda”, “Scripts”, “Modules”, “Configs”, “Databases” have to be downloaded, as the pipeline works with their pathways.

# Dependencies:

To run the overall steps, you will need Nextflow installed as well as either Conda, Java, R, Blast and KMA. 
# Install Nextflow
               curl -s https://get.nextflow.io | bash
           
         #Make Nextflow executable
	       chmod +x nextflow
	
	       #Move Nextflow int an executable path
	       sudo mv nextflow /usr/local/bin
	
	       #Confirm that Nextflow is installed correctly
	       nextflow info

# Install Conda
	 mkdir -p ~/miniconda3

         wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh

         bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

         rm -rf ~/miniconda3/miniconda.sh

	       ~/miniconda3/bin/conda init bash
         ~/miniconda3/bin/conda init zsh

# Install Java
	       sudo apt install openjdk-19-jdk

	       #Confirm that Java is installed correctly
	       java -version

# Install R
	       wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.12.1-402-amd64.deb
                
	       #Update indices
	       sudo apt install -f ./rstudio-2023.12.1-402-amd64.deb
	       #Install two helper packages we need	
   	     sudo apt install --no-install-recommends software-properties-common dirmngr

	       #Add the signing key (by Michael Rutter) for these repos
	       #To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
	       #Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
	       wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | 
         sudo tee -a /etc/apt/trusted.gpg.d/   cran_ubuntu_key.asc

	       #Add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
	       sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
	     
	       #Install r-base language
	       sudo apt install --no-install-recommends r-base
	       sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+

	     !!! * Please check the "openxlsx" package installation, to ensure correct and error-free use * !!!

# Install Blast
         sudo apt-get install ncbi-blast+

# Install KMA
	 sudo apt install make
	 sudo apt install build-essential

         sudo apt update
         sudo apt upgrade

         make 
         sudo apt-get install libz-dev
         make 

         git clone https://bitbucket.org/genomicepidemiology/kma.git
         cd kma && make

# Pipeline summary

The pipeline can perform the following procedures:

    • Sequencing quality control (before and after trimming, enabled by FastQC, MultiQC)
    • Trimming (by fastp)
    • De-novo assembly (via SPAdes)
    • Quality assesment for draft genome assembly (by QUAST)
    • Multi-locus Sequence Typing (with MLST)
    • Screening for antibiotic resistant genes (by ABRicate with resfinder, AMRFinder)
    • Screening for antibiotic resistant replicons (by ABRicate with PlasmidFinder)
    • Screening of virulence factors (by ABRicate with VirulenceFinder)
    • Detection of resistance-associated point mutations (via Pointfinder)
    • Production of HTML interactive report (with R)

# Usage

The standard command for running the pipeline is as follows: 
	
 nextflow run entero.nf --reads “/path/to/raw_reads” \/
 
 				    --outdir “/path/to/store/final_results” \/
	 
   				  --temporary_quast_dir “/path/to/temporary_quast_results” \/
	 
				    --temporary_fasta_dir  “/path/to/temporary_fasta_results” \/
	
				    --point_results_dir “/path/to/temporary_points_results” \/
	
			            --amrfinder_results_dir “/path/to/temporary_amrfinder_results” \/
	       
				    --threads “int” \/
	
				    --update_db “yes” \/
	
				    --codes_file “/path/to/save/ids_isolates_file.txt” \/
	
				    -bg

-reads >>> mandatory, it indicates folder the reads are located in;
-outdir >>> mandatory, it denotes where storing the final results;
-temporary_quast_dir >>> mandatory, it implies where storing the quast temporary results;
-temporary_fasta_dir >>> mandatory, it signifies where saving the temporary fasta assemblies;
-point_results_dir >>> mandatory, it means where storing the temporary points results;
-amrfinder_results_dir >>> mandatory, it represents where saving the temporary amrfinder results;
-threads >>> specifies how many threads to use ---type: INT, default: 0;
-update_db >>> it says if updating amrfinder, resfinder, plasmidfinder, virulencefinder, amrfinder, pointfinder databases before analyses ---type: BOOLEAN, default: “no”;
-codes_file >>> mandatory, it denotes where storing the IDs of each isolate file;
-bg >>> denotes whether running pipeline in background;

# Output

As previously stated, the main output is a “html” interactive report file in the ‘outdir’ folder, composed of several navigable sections, mostly provided by quality check tools, such as FastQC, MultiQC, QUAST, for raw reads and completed assemblies, and genotyping/characterization tools, like MLST, ResFinder, AMRfinder, PlasmidFinder, VirulenceFinder and PointFinder, in order to present the genomic results of all bioinformatics analyses and serve as a resource that may simplify the reporting phase.

Other outputs are provided always in ‘outdir’/’annotation’/ folder, since they are the “txt” files needed by ‘Rscript’ to produce the interactive html report file.
Finally, a ‘temporary_fasta_dir’ folder are saved in the directory the ‘entero.nf’ are placed in, and it can be useful for a quickly consulting of completed genome assemblies.
In this directory even a ‘pipeline_info’ folder will be stored, in which user can check status and progress of the workflow.
