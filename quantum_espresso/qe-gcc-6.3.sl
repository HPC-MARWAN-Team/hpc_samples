#!/bin/bash
#SBATCH -J QE_GCC
#SBATCH --ntasks=32
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
source /cm/shared/apps/intel/ips_2017/bin/compilervars.sh -arch intel64
ml openmpi/gcc/64/1.10.7
ml qe/openmpi/gcc/64/6.3.0
ml slurm/17.11.8

#prepare working directory 
export WORK_DIR=/data/$USER/${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

export ESPRESSO_PSEUDO=/data/$USER/pseudo
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Quantum Espresso with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS pw.x -i test.pw-in > test.pw-out

echo "End"
