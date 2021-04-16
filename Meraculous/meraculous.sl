#!/bin/bash
#SBATCH -J Meraculous
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules 
module load Meraculous

#prepare working dir 
export WORK_DIR=/data/$USER/Meraculous_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/pipeline

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Meraculous  at $WORK_DIR"

run_meraculous.sh -c meraculous.config

echo "DONE"
