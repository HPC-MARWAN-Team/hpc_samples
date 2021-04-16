#!/bin/bash
#SBATCH -J QE
#SBATCH --ntasks=16
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load qe requirement
module load blas/gcc/64/3.8.0
module load lapack/gcc/64/3.8.0
module load hdf5/1.10.1
module load slurm/17.11.8
module load openmpi/gcc/64/2.0.2

#load qe
module load qe/openmpi/gcc/64/6.4.1

#prepare work dir
export WORK_DIR=/data/$USER/Qe${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

export ESPRESSO_PSEUDO=/data/$USER/pseudo
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#run
echo "Running Quantum Espresso with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS pw.x -i myInputFile.in > myOutputFile.out

echo "Done"
