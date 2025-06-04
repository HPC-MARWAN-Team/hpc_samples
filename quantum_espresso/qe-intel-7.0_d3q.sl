#!/bin/bash
#SBATCH -J QE_GCC
#SBATCH --ntasks=32
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH --mem-per-cpu=10G # la taille de mémoire par cpu que vous estimez nécessaire pour votre calcul.
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
module load intel2021/mpi intel2021/mkl intel2021/compiler OpenMPI/4.1.4-GCC-12.2.0 

module load QuantumEspresso/intel/7.0_d3q


#prepare working directory 
export WORK_DIR=/home/$USER/${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput
export ESPRESSO_PSEUDO=/home/$USER/pseudo
export OMP_NUM_THREADS=1

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running Quantum Espresso with $SLURM_NTASKS at $WORK_DIR"
echo "pw calculation"
mpirun -np $SLURM_NTASKS pw.x -i test.pw-in > test.pw-out

echo "d3 calculation"
mpirun -np $SLURM_NTASKS d3q.x -in test.d3.in > test.d3.out

echo "End"
