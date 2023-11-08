#!/bin/bash
 
### GPU batch job ###

#SBATCH --job-name=jobname            
#SBATCH --account=alloc-code-gpu    
#SBATCH --nodes=1                  
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4                          
#SBATCH --mem=16G                  
#SBATCH --time=01:00:00             
#SBATCH --gpus-per-node=1
#SBATCH --output=output.txt         
#SBATCH --error=error.txt          
#SBATCH --mail-user=your.name@ubc.ca
#SBATCH --mail-type=ALL                               
 
################################################################################
 
module load gcc
module load cuda
module load <software_package_1>
module load <software_package_2>
 
cd $SLURM_SUBMIT_DIR
 
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

<gpu_executable>