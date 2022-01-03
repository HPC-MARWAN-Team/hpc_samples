#!/bin/bash
#SBATCH -J wannier90 #jobname
#SBATCH --ntasks=8 #number of cpus
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq #partition depending on job duration
#SBATCH --constraint=opa
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules

module load intel2021/compiler
module load intel2021/mpi
module load intel2021/mkl
module load openmpi4-ofed54/4.1.2a1
module load Wannier90/3.1.0


#prepare working directory
export WORK_DIR=/data/$USER/workdir/wannier90_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running wannier90 with $SLURM_NTASKS at $WORK_DIR"

wannier90.x Si

mpirun -np 8 postw90.x Si


echo "Done"
