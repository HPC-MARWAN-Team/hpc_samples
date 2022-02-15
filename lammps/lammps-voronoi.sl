#!/bin/bash
#SBATCH --job-name=lmp-demo
#SBATCH --ntasks-per-core=1
#SBATCH --ntasks=4
#SBATCH --partition=defq
#SBATCH --constraint=ib
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load the module 
module load lammps-20210310-gcc-10.2.0-ilp5cpz

#inspect job 
scontrol  show jobid -dd ${SLURM_JOB_ID}

#create work directory 
export WORK_DIR=/scratch/users/$USER/LMP${SLURM_JOB_ID}
#declare input directory 
export INPUT_DIR=$PWD/input

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

echo "Running Lammps with  $SLURM_NTASKS  at : $WORK_DIR"

srun lmp -in myInput.in

echo "JOB Done"
