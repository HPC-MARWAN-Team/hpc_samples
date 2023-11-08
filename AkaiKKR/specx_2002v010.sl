#!/bin/bash
#SBATCH -J SPECX
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load intel2021/compiler
module load Akaikkr/2002v010


scontrol  show jobid -dd ${SLURM_JOB_ID}


#prepare work_dir
export WORK_DIR=$PWD/Akai${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR

cp  $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

echo "Lancement de SPECX  at $WORK_DIR"

./specx<Test.inp>go.out

echo " Termine "
