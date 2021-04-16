#!/bin/bash
#SBATCH -J Root
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
module load root/gcc/64/6.16.00
module load cmake/gcc/64

#prepare working directory
export WORK_DIR=/data/$USER/root_$SLURM_JOB_ID
export INPUT_DIR=$PWD/hist

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR

echo "Running root in $WORK_DIR"

cd $WORK_DIR
root -b -q hsum.C

echo "Done"
