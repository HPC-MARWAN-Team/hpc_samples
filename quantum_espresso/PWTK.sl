#!/bin/bash
#SBATCH -J QE_PWTK
#SBATCH --ntasks=10
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


#load qe requirement
module load blas/gcc/64/3.8.0
module load lapack/gcc/64/3.9.0
module load fftw3/openmpi/gcc/64/3.3.8
module load openmpi/gcc/64/1.10.7
module load hdf5/1.10.1
module load intel2021/mkl/latest

#load qe


module load QuantumESPRESSO/gcc/64/7.0
module load PWTK/2.0



#prepare work dir
export WORK_DIR=/data/$USER/workdir/QePWTK_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/INPUT

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

export ESPRESSO_PSEUDO=/data/$USER/pseudo

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#run
echo "Running Quantum Espresso PWTK with $SLURM_NTASKS at $WORK_DIR"

pwtk input.pwtk

echo "Done"
