#!/bin/bash

### OpenMP job script ###

#SBATCH --account=alloc-code
#SBATCH --time=00:10:00
#SBATCH --cpus-per-task=4
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem=8G
#SBATCH --job-name=openmp_job
#SBATCH --output=out-%x-%j.txt
#SBATCH --error=err-%x-%j.txt 
#SBATCH --mail-user=your.email@ubc.ca
#SBATCH --mail-type=ALL
 
# Load necessary software modules
 
module load software_package_1
module load software_package_2
 
# Navigate to the job's working directory
cd $SLURM_SUBMIT_DIR
 
# Set the number of OpenMP threads
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
 
# Add your OpenMP-enabled executable commands here
./your_openmp_executable
