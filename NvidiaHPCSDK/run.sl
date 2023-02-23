#! /bin/bash
#SBATCH --job-name=add_nvhpc
#SBATCH --partition=gpu-testq #partition de test limitée a 2h, changer à gpu-prodq
#SBATCH --gres=gpu:1
#SBATCH --account=gpu_users

#charger le module 
module load nvhpc/21.9

#compiler le code
nvcc myCode.cu -o myCode
#executer le code 
./myCode
