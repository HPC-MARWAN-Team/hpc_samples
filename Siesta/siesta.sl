#!/bin/bash
#SBATCH -J Siesta_h2O
#SBATCH --ntasks=10
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH --constraint=ib
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load siesta/gcc/64/openmpi/4.1.5

export WORK_DIR=/data/$USER/siesta${SLURM_JOB_ID}
export INPUT_DIR=$PWD/H2O

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Siesta with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS siesta < h2o.fdf > h2o.out

echo "End"
