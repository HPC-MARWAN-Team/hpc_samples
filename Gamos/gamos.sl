#!/bin/bash
#SBATCH -J Gamos
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load gamos
source /data/shared/apps2/gamos/gcc/6.0/GAMOS.6.0.0/config/confgamos.sh

#prepare working dir
export WORK_DIR=/data/$USER/gamos${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

echo "Running Gamos  at $WORK_DIR"

gamos exercise0a.in

echo "Done"
