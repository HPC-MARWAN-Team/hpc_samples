#!/bin/bash
#SBATCH -J abinit
#SBATCH --ntasks=32
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules 
module load abinit-9.4.2-gcc-10.2.0-rezdixl


#prepare working dir 
export WORK_DIR=/home/$USER/Abinit_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input_dir

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running abinit with np=$SLURM_NTASKS  at $WORK_DIR"

run abinit  input.abi >& log

echo "DONE"
