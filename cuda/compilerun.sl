#!/bin/bash
#SBATCH --job-name="GPU_test"
#SBATCH --partition=gpu-testq #partition de test limitée a 2h, changer à gpu-prodq 
#SBATCH --gres=gpu:1
#SBATCH --account=gpu_users
#SBATCH --qos=gpu
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
module unload gcc/7.2.0
module load cuda10.1/toolkit


export WORK_DIR=$PWD/${SLURM_JOB_ID}
export INPUT_DIR=$PWD

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR

echo "creating work dir $WORK_DIR `hostname`"
cd $WORK_DIR


nvcc samplecpp.cu -o samplecpp.o
srun ./samplecpp.o
