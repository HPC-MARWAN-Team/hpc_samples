#!/bin/bash
#SBATCH --job-name=myPythonjob
#SBATCH --partition=defq #partition de test limitée a 2h, changer à shortq mediumq ou longq selon durée estimée  
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

export CONDA_ENVS_PATH=/home/$USER/envs
module load Anaconda3
source activate my_env_3.6
unset PYTHONPATH
python myPythonCode.py
