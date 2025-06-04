#!/bin/bash
#SBATCH -J FreeFem #jobname
#SBATCH --partition=defq #partition depending on job duration
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
module load freefem-4.10-gcc-10.2.0-p2i6276

#prepare working directory
export WORK_DIR=/home/$USER/freefem_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running FreeFem with at $WORK_DIR"

FreeFem++ -nw sample.edp > sample.out

echo "Done"
