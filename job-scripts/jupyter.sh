#!/bin/bash
 
### Jupyter job script ### 

##### For information re: set-up see: https://confluence.it.ubc.ca/x/9THoD #####

#SBATCH --job-name=my_jupyter_notebook
#SBATCH --account=<st-alloc-1>
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@ubc.ca
 
################################################################################
 
# Change directory into the job dir
cd $SLURM_SUBMIT_DIR
 
# Load software environment
module load gcc
module load apptainer
 
# Set RANDFILE location to writeable dir
export RANDFILE=$TMPDIR/.rnd
  
# Generate a unique token (password) for Jupyter Notebooks
export APPTAINERENV_JUPYTER_TOKEN=$(openssl rand -base64 15)
 
# Find a unique port for Jupyter Notebooks to listen on
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
 
# Print connection details to file
cat > connection_${SLURM_JOB_ID}.txt <<END
 
1. Create an SSH tunnel to Jupyter Notebooks from your local workstation using the following command:
 
ssh -N -L 8888:${HOSTNAME}:${PORT} ${USER}@sockeye.arc.ubc.ca
 
2. Point your web browser to http://localhost:8888
 
3. Login to Jupyter Notebooks using the following token (password):
 
${APPTAINERENV_JUPYTER_TOKEN}
 
When done using Jupyter Notebooks, terminate the job by:
 
1. Quit or Logout of Jupyter Notebooks
2. Issue the following command on the login node (if you did Logout instead of Quit):
 
scancel ${SLURM_JOB_ID}
 
END

#
##
### ENSURE YOU EDIT THE APPROPRIATE FILE PATHS AND CONTAINER NAME IN THE COMMAND BELOW!!!
##
#

# Execute jupyter within the Apptainer container
apptainer exec --home /scratch/<st-alloc-1>/<cwl>/my_jupyter --env XDG_CACHE_HOME=/scratch/<st-alloc-1>/<cwl>/my_jupyter /arc/project/<st-alloc-1>/<cwl>/jupyter/jupyter-datascience.sif jupyter notebook --no-browser --port=${PORT} --ip=0.0.0.0 --notebook-dir=$SLURM_SUBMIT_DIR
