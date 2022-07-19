#!/bin/bash
#SBATCH -J S4
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
module load S4/1.1.1-20180610-foss-2020a

#prepare working dir
export WORK_DIR=$PWD/S4_$SLURM_JOB_ID
export INPUT_DIR=$PWD/polarization_basis/
mkdir -p $WORK_DIR
cp $INPUT_DIR/* $WORK_DIR

#run
echo "Running S4 in $WORK_DIR"
cd $WORK_DIR
S4 tri.lua 
echo "Done"
