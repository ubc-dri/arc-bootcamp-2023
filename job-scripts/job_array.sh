#!/bin/bash

### Array job script ###

#SBATCH --account=alloc-code
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --array=1-10
#SBATCH --mail-user=your.email@ubc.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=array_example_%A_%a.out
#SBATCH --error=array_example_%A_%a.err

################################################################################

# Load necessary software modules
 
module load software_package_1
module load software_package_2
 
# Navigate to the job's working directory
cd $SLURM_SUBMIT_DIR
 
# Add your executable commands here
./your_array_executable $SLURM_ARRAY_TASK_ID
