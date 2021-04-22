#!/bin/bash
#SBATCH -J GPAW
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
#SBATCH --partition=shortq

module load GPAW/20.1.0-foss-2019b-Python-3.7.4


#prepare work_dir

export WORK_DIR=/data/$USER/GPAW_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

mkdir -p $WORK_DIR

cp -R $INPUT_DIR/* $WORK_DIR   

cd $WORK_DIR

echo "Running code on $WORK_DIR"

python3 script.py

echo "Done"
