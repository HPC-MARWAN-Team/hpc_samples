#!/bin/bash
#SBATCH --job-name=myGPUjob
#SBATCH -N 1
#SBATCH --partition=gpu-testq #partition de test limitée a 2h, changer à gpu-prodq 
#SBATCH --gres=gpu:2
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load cuda10.1/toolkit/10.1.243
module load cudnn
export CONDA_ENVS_PATH=/data/$USER/envs
module load Anaconda3
source activate my_env_3.6
unset PYTHONPATH
python myPythonCode.py
