#!/bin/bash
#SBATCH -J Sage_test
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
#SBATCH --partition=shortq

 module load SageMath/gcc/64/9.2


#prepare work_dir

export WORK_DIR=/data/$USER/workdir/sage_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

mkdir -p $WORK_DIR

cp -R $INPUT_DIR/* $WORK_DIR   

cd $WORK_DIR

echo "Running code on $WORK_DIR"

sage homology.sage

echo "Done"

