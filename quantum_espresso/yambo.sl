#!/bin/bash
#SBATCH -J QEY
#SBATCH --ntasks=4
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


module load QuantumESPRESSO/6.8-intel-2021a
module load Yambo/5.0.4-intel-2021a

export WORK_DIR=$PWD/${SLURM_JOB_NAME}_${SLURM_JOB_ID}

echo "Running PW and Yambo on $SLURM_JOB_NODELIST   "

mkdir -p $WORK_DIR
cp -R $PWD/inputs  $WORK_DIR
cp -R $PWD/psps  $WORK_DIR
cd $WORK_DIR

mpirun -np $SLURM_NTASKS pw.x < inputs/scf.in > scf.out
mpirun -np $SLURM_NTASKS pw.x < inputs/nscf.in > nscf.out
cd Input.save
p2y
yambo -F inputs/01_init -J 01_init
echo "DONE" 

