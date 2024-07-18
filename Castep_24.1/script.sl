#!/bin/bash
#SBATCH -J Castep
#SBATCH --ntasks=20
#SBATCH --ntasks-per-core=1
#SBATCH --partition=mediumq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

sg castepgroup

#load castep requirement
module load intel2021/mpi intel2021/mkl intel2021/compiler lapack/gcc/64/3.9.0 blas/gcc/64/3.8.0

#load castep

module load CASTEP/24.1

#prepare work dir
export WORK_DIR=/scratch/users/$USER/workdir/CASTEP_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }


mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#run
echo "Running castep with $SLURM_NTASKS at $WORK_DIR"

castep.mpi Fe    

echo "Done"
