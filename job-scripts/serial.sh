#!/bin/bash

### Serial job script ###

#SBATCH --time=00:10:00
#SBATCH --account=st-cwl-1
#SBATCH --ntasks=1
#SBATCH --mem=6G
#SBATCH --job-name=serial_job
#SBATCH --output=out-%x-%j.txt
#SBATCH --error=err-%x-%j.txt
#SBATCH --mail-user=your.email@ubc.ca
#SBATCH --mail-type=ALL
 
################################################################################
 
# Load necessary modules
module load python/3.8.10
 
# Navigate to the job's working directory
cd $SLURM_SUBMIT_DIR
 
# Add your executable commands here, for example:
python3 myscript.py
