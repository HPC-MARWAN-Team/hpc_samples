#!/bin/bash
#SBATCH --partition=shortq
#SBATCH --job-name="Julia_test"
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

 module load Julia/1.5.1-linux-x86_64

#prepare work_dir

export WORK_DIR=/data/$USER/Julia_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

mkdir -p $WORK_DIR

cp -R $INPUT_DIR/* $WORK_DIR   

cd $WORK_DIR

echo "Running code on $WORK_DIR"


julia myscript.jl

echo "Done"
