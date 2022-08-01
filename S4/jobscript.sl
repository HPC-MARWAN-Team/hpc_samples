#!/bin/bash
#SBATCH -J S4test
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load application 

module load S4/1.1.1-20180610-foss-2020a

#prepare work_dir 
export WORK_DIR=$PWD/${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

echo "Lancement de S4   at $WORK_DIR"

S4 fichier_input.lua 

echo " Termine "
