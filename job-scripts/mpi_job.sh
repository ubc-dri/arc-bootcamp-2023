#!/bin/bash

#SBATCH --account=alloc-code
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --ntasks-per-node=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=6GB
#SBATCH --time=10:00:00
#SBATCH --job-name=mpi_job
#SBATCH -e slurm-%j.err
#SBATCH -o slurm-%j.out 
#SBATCH --mail-user=your.email@ubc.ca
#SBATCH --mail-type=ALL
 
################################################################################

# Load necessary software modules
 
module load gcc
module load openmpi/4.1.1-cuda11-3
 
# Navigate to the job's working directory
cd $SLURM_SUBMIT_DIR
 
# Add your MPI executable commands here

mpirun ./your_mpi_executable