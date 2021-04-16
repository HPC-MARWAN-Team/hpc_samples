#!/bin/bash
#SBATCH -J cp2k_OMP
#SBATCH -n 40
#SBATCH -N 1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


# get number of threads from slurm job 
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
else
    OMP_NUM_THREADS=1
fi
#load modules 
module load cp2k/ssmp/6.1

#prepare working dir  
export WORK_DIR=/data/$USER/${SLURM_JOB_ID}
export INPUT_DIR=/home/$USER/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR/
cd $WORK_DIR/

echo "Running cp2k on $WORK_DIR with "

cp2k -i test.inp -o test.out

echo "Done "
