#!/bin/bash
#SBATCH -J abinit
#SBATCH --ntasks=32
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules 
source /cm/shared/apps/intel/ips_2017/bin/compilervars.sh -arch intel64 -platform linux
module load abinit/intel

#prepare working dir 
export WORK_DIR=/data/$USER/Abinit_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/test_paral

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running abinit with np=$SLURM_NTASKS  at $WORK_DIR"

mpirun -np $SLURM_NTASKS abinit < tbasepar_1.files >& log

echo "DONE"
