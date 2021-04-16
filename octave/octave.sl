#!/bin/bash
#SBATCH -J Octave
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


module load gcc/7.2.0
module load octave/gcc/5.1.0

export WORK_DIR=/data/$USER/Octav_$SLURM_JOB_ID
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -r $INPUT_DIR/* $WORK_DIR

echo "Running Octave in $WORK_DIR"

cd $WORK_DIR

octave test.m > test.out

echo "Done"
