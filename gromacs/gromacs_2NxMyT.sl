#!/bin/bash
#SBATCH -J Gromacs
#SBATCH --partition=defq
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=8
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load gromacs
module load GROMACS/2021.3-foss-2021a

#prepare working dir 
export WORK_DIR=$PWD/gmx${SLURM_JOB_ID}
export INPUT_DIR=$PWD/ubiquitin

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Gromacs at $WORK_DIR"
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

mpirun -np $SLURM_NTASKS gmx_mpi mdrun -ntomp ${SLURM_CPUS_PER_TASK} -v -deffnm em

echo "Done"
