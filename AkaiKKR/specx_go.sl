#!/bin/bash
#SBATCH -J SPECX_GO
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#prepare work_dir 
export WORK_DIR=/data/$USER/Akai${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

echo "Lancement de SPECX  at $WORK_DIR"

./specx<Test.inp>go.out

echo " Termine "
