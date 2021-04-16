#!/bin/bash
#SBATCH --job-name="GPU_test"
#SBATCH --partition=gpu-testq #partition de test limitée a 2h, changer à gpu-prodq 
#SBATCH --gres=gpu:1
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
module unload gcc/7.2.0
module load cuda10.1/toolkit


export WORK_DIR=$PWD/${SLURM_JOB_ID}
export INPUT_DIR=$PWD

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR

echo "creating work dir $WORK_DIR `hostname`"
cd $WORK_DIR


nvcc samplecpp.cu -o samplecpp.o
srun ./samplecpp.o
