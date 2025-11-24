cd ${TEST}/databases/

git clone https://bitbucket.org/genomicepidemiology/resfinder_db/
git clone https://bitbucket.org/genomicepidemiology/pointfinder_db/
git clone https://bitbucket.org/genomicepidemiology/disinfinder_db/

#Set approximate environment variables.

# Example on how to set the environment variables in bash.
#Remember this is only temporary, should you want them set permanently, add this line to your .bashrc file in the home directory.
#CGE_RESFINDER_RESGENE_DB="/path/to/some/dir/resfinder_db"
#CGE_RESFINDER_RESPOINT_DB="/path/to/some/dir/pointfinder_db"
#CGE_DISINFINDER_DB="/path/to/some/dir/disinfinder_db"

# Indexing DATABASES for usage with KMA. 
# Inside the directory created from KMA.git, kma_index contains all commands for the installation of the resfinder and pointfinder databases.



cd ${TEST}/databases/resfinder_db/
python3 INSTALL.py ${KMA_INDEX} non_interactive

cd ${TEST}/databases/pointfinder_db/
python3 INSTALL.py ${KMA_INDEX} non_interactive

