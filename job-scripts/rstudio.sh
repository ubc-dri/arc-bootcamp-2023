#!/bin/bash

### RStudio job script ### 

##### For information re: set-up see: https://confluence.it.ubc.ca/x/CbC3D #####

#SBATCH --time=03:00:00 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=5gb
#SBATCH --job-name=my_rstudio_server
#SBATCH --account=<st-alloc-1>
#SBATCH --mail-type=ALL
#SBATCH --mail-user=<your.email@ubc.ca
 
################################################################################
 
# Change directory into the job dir
cd $SLURM_SUBMIT_DIR  
 
# Load software environment
module load gcc apptainer
 
# Set RANDFILE location to writeable dir
export RANDFILE=$TMPDIR/.rnd
 
# Generate a unique password for RStudio Server
export APPTAINERENV_PASSWORD=$(openssl rand -base64 15)
 
# Find a unique port for RStudio Server to listen on
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
 
# Set per-job location for the rserver secure cookie
export SECURE_COOKIE=$TMPDIR/secure-cookie-key
 
# Print connection details to file
cat > connection_${PBS_JOBID}.txt <<END
 
1. Create an SSH tunnel to RStudio Server from your local workstation using the following command:
 
ssh -N -L 8787:${HOSTNAME}:${PORT} ${USER}@sockeye.arc.ubc.ca
 
2. Point your web browser to http://localhost:8787
 
3. Login to RStudio Server using the following credentials:
 
Username: ${USER}
Password: ${APPTAINERENV_PASSWORD}
 
When done using RStudio Server, terminate the job by:
 
1. Sign out of RStudio (Left of the "power" button in the top right corner of the RStudio window)
2. Issue the following command on the login node:
 
scancel $job_id
 
END
 
# Optional: You can modify this container by installing custom R packages/libraries in your local PC with root access. In this case, you have to set LD_LIBRARY_PATH to make Rstudio use the system dependencies built in the container, which are located in "/usr/lib/x86_64-linux-gnu".
export APPTAINERENV_LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

#
##
### ENSURE YOU EDIT THE APPROPRIATE FILE PATHS AND CONTAINER NAME IN THE COMMAND BELOW!!!
##
#

# Execute the rserver within the rocker/rstudio container
apptainer exec --bind $TMPDIR:/var/run/ --bind $TMPDIR:/var/lib/rstudio-server --home /scratch/<st-alloc-1>/<cwl>/my_rstudio /arc/project/<st-alloc-1>/rstudio/rstudio.sif rserver --auth-none=0 --auth-pam-helper-path=pam-helper --secure-cookie-key-file ${SECURE_COOKIE} --www-port ${PORT} --server-user ${USER}
