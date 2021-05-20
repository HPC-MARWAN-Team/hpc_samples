#!/bin/bash
#SBATCH -J FreeFem4.6 #jobname
#SBATCH --partition=defq #partition depending on job duration
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules

module load GCC/9.3.0
module load FreeFem++/gcc/64/4.6


#prepare working directory
export WORK_DIR=/data/$USER/freefem_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running FreeFem with at $WORK_DIR"

FreeFem++ -nw sample.edp > sample.out

echo "Done"
