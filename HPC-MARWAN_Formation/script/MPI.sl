#!/bin/bash
#SBATCH --job-name=TestMPI_intel
#SBATCH --partition=demoq #partition de test 
#SBATCH --account=marwan 
#SBATCH --ntasks=16
#SBATCH -o %x-%j.out 
#SBATCH -e %x-%j.err
 
#chargement des modules 
#module load  OpenMPI/4.1.4-GCC-12.2.0
module load intel/2023a


export WORK_DIR=$PWD/../workdir/MPI_${SLURM_JOB_ID}

export INPUT_DIR=$PWD/../input/MPI  # chemin vers mon code mpi hello word

#creation de l espace de travail 
mkdir -p $WORK_DIR

#copier les inputs dans le dossier de travail 
cp -R $INPUT_DIR/* $WORK_DIR

cd $WORK_DIR

echo "espace de travail $WORK_DIR" 

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

echo "Compiling code mpi C++"

mpicc -o mpi_hw mpi_hw.c   # mpi_hw. est juste un code de hello word mpi

echo "Running "

mpirun -np $SLURM_NTASKS ./mpi_hw



echo "Done"
