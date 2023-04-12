#!/bin/bash
#SBATCH -J Gromacs
#SBATCH --partition=gpu-testq
#SBATCH --account=gpu_users
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load gromacs with gpu support (cuda)
module load GROMACS/2021.3-foss-2021a-CUDA-11.3.1

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

#specify forcefied and water   -ff and -water 
gmx_mpi pdb2gmx -f 1ubq.pdb -o protein.gro  -ff amber03 -water tip3p

#some other gromacs steps ... 

gmx_mpi mdrun -v   -deffnm em

echo "Done"
