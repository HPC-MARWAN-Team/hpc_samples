#!/bin/bash
#SBATCH -J QE_Thermo
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
export WORK_DIR=/data/$USER/QeThermo${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput
export ESPRESSO_PSEUDO=/data/$USER/pseudo
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#run
echo "Running Quantum Espresso with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS thermo_pw.x -i myInputFile.in > myOutputFile.out

echo "Done"
