#!/bin/bash
#SBATCH -J Openbabel
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


#load openbabel

module load openbabel-3.0.0-gcc-10.2.0-hensxki

#prepare work_dir
export WORK_DIR=/home/$USER/workdir/Openbabel${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#run
echo "Running Openbabel at $WORK_DIR"

obabel -isdf *.sdf -opdbqt -O *.pdbqt

echo "Done"
