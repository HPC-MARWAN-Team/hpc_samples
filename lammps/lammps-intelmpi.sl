#!/bin/bash
#SBATCH -J LMP
#SBATCH --ntasks=16
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH --constraint=opa
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


module load intel2021/compiler
module load binutils/2.34-GCCcore-9.3.0
module load intel2021/mpi
module load LAMMPS/28Mars2023

export WORK_DIR=/data/$USER/LMP${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Lammps with  $SLURM_NTASKS at : $WORK_DIR"

mpirun -np $SLURM_NTASKS lmp -in indent.in.min

echo "JOB Done"
