#!/bin/bash
#SBATCH -J FreeFem #jobname
#SBATCH --ntasks=12 #number of cpus
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq #partition depending on job duration
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules

module load intel2021/compiler
module load intel2021/mpi/2021.4.0
module load hdf5/1.10.1
module load openmpi/gcc/64/1.10.7

module load FreeFem/intel/4.12

#prepare working directory
export WORK_DIR=/data/$USER/workdir/freefem_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running FreeFem with at $WORK_DIR"

mpirun -np $SLURM_NTASKS FreeFem++-mpi test.edp > sample.out

echo "Done"
