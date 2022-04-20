#!/bin/bash
#SBATCH -J ORCA_Job
#SBATCH --ntasks=4
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load Orca/openmpi/5.0.1
module load openmpi-4.1.1-gcc-10.2.0-f4hp5zh


export WORK_DIR=/data/$USER/Orca_${SLURM_JOB_ID}
export INPUT_FILE=$PWD/input4cpu.in

[[ -z $INPUT_FILE ]] && { echo "Error: Input File (INPUT_FILE) is not defined "; exit 1; }
[[ ! -F $INPUT_FILE ]] && { echo "Error:Input File (INPUT_FILE) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp $INPUT_FILE $WORK_DIR

echo "Running orca with $SLURM_NTASKS at $WORK_DIR"

cd $WORK_DIR
$ORCA_PATH/orca  input4cpu.in

echo "Done"
