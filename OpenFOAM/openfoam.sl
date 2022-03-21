#!/bin/bash
#SBATCH -J OpenFoam
#SBATCH --ntasks=16
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load openfoam-2106-gcc-10.2.0-rmtst2n

source $OPENFOAM_BASH

export WORK_DIR=/data/$USER/OF_${SLURM_JOB_ID}
export INPUT_DIR=/home/$USER/cavity

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -r $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

echo "Lancement de OpenFoam with  $SLURM_NTASKS at $WORK_DIR"

decomposePar
mpirun -np $SLURM_NTASKS  icoFoam -parallel
reconstructPar

echo " Termine "
