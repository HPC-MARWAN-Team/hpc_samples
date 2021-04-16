#!/bin/bash
#SBATCH -J Siesta_h2O
#SBATCH --ntasks=32
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


ml openmpi/gcc/64/1.10.7
ml siesta/gcc/64/openmpi/4.1-b4
ml slurm/17.11.8


export WORK_DIR=/data/$USER/siesta${SLURM_JOB_ID}
export INPUT_DIR=$PWD/H2O

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Siesta with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS siesta < h2o.fdf > h2o.out

echo "End"
