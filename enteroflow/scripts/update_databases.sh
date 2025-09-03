cd ${TEST}/databases/

git clone https://bitbucket.org/genomicepidemiology/resfinder_db/
git clone https://bitbucket.org/genomicepidemiology/pointfinder_db/
git clone https://bitbucket.org/genomicepidemiology/disinfinder_db/

#Set approximate environment variables.

# Example of how to set the environment variable in the bash shell.
#Remember this is only temporary, if you want it set every time you log in you need to add this line to for example your .bashrc file.
#CGE_RESFINDER_RESGENE_DB="/path/to/some/dir/resfinder_db"
#CGE_RESFINDER_RESPOINT_DB="/path/to/some/dir/pointfinder_db"
#CGE_DISINFINDER_DB="/path/to/some/dir/disinfinder_db"






#INDICIZZARE I DATABASES PER KMA . Vai nella cartella del clone KMA.git per trovare kma_index
#Sono i comandi che installeranno i databases nuovi di resfinder e pointfinder


cd ${TEST}/databases/resfinder_db/
python3 INSTALL.py ${KMA_INDEX} non_interactive

cd ${TEST}/databases/pointfinder_db/
python3 INSTALL.py ${KMA_INDEX} non_interactive

