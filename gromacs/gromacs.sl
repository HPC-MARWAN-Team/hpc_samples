#!/bin/bash
#SBATCH -J Gromacs
#SBATCH --partition=shortq
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load gromacs
module load GROMACS/2019.3-foss-2019b

#prepare working dir 
export WORK_DIR=/data/$USER/gmx${SLURM_JOB_ID}
export INPUT_DIR=$PWD/ubiquitin

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

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

gmx_mpi pdb2gmx -f 1ubq.pdb -o protein.gro 

#some other gromacs steps ... 

mpirun -np $SLURM_NTASKS  gmx_mpi mdrun -v -deffnm em


echo "Done"
