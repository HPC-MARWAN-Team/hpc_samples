#!/bin/bash
#SBATCH -J honpas
#SBATCH --ntasks=20
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


module load HONPAS/intel/4.1.5

export WORK_DIR=/data/$USER/workdir/honpas_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Honpas with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS honpas < As_HSE.fdf > As_HSE.out

echo "End"
