#!/bin/bash
#SBATCH -J QE_GCC
#SBATCH --ntasks=32
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
ml openmpi/gcc/64/1.10.7
ml qe/openmpi/gcc/64/6.3.0
ml slurm/17.11.8

#prepare working directory 
export WORK_DIR=/data/$USER/${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput
export ESPRESSO_PSEUDO=/data/$USER/pseudo
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Quantum Espresso with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS pw.x -i test.pw-in > test.pw-out

echo "End"
