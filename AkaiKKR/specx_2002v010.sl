#!/bin/bash
#SBATCH -J SPECX
#SBATCH --partition=defq
#SBATCH --time=0-00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load intel2021/compiler
module load Akaikkr/2002v010


scontrol  show jobid -dd ${SLURM_JOB_ID}


#prepare work_dir
export WORK_DIR=$PWD/Akai${SLURM_JOB_ID}
export INPUT_DIR=$PWD/in

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
mkdir $WORK_DIR/data
cp  $INPUT_DIR/co $WORK_DIR
cd $WORK_DIR

echo "Lancement de SPECX  at $WORK_DIR"
