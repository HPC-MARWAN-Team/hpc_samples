#!/bin/bash
#SBATCH -J ORCA_Job
#SBATCH --ntasks=4
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load openmpi/gcc/64/2.0.2
module load orca/openmpi/4.0.1.2


export WORK_DIR=/data/$USER/Orca_${SLURM_JOB_ID}
export INPUT_FILE=$PWD/input4cpu.in
mkdir -p $WORK_DIR
cp $INPUT_FILE $WORK_DIR

echo "Running orca with $SLURM_NTASKS at $WORK_DIR"

cd $WORK_DIR
$ORCA_PATH/orca  input4cpu.in

echo "Done"
