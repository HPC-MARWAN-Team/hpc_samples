#!/bin/bash
#SBATCH -J FreeFem #jobname
#SBATCH --partition=defq #partition depending on job duration
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
source /cm/shared/apps/intel/ips_2017/bin/compilervars.sh -arch intel64 -platform linux
module load FreeFem++/intel

#prepare working directory
export WORK_DIR=/data/$USER/freefem_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running FreeFem with at $WORK_DIR"

FreeFem++ -nw sample.edp > sample.out

echo "Done"
