#!/bin/bash
#SBATCH -p defq            # Submit to 'defq' Partitiion 
#SBATCH --constraint=opa
#SBATCH -J MPIFortran          # Name the job as 'MPIFortran'
#SBATCH -o MPIFortran-%j.out   # Write the standard output to file named 'jMPItest-<job_number>.out'
#SBATCH -e MPIFortran-%j.err   # Write the standard error to file named 'jMPItest-<job_number>.err'
#SBATCH -t 0-12:00:00        # Run for a maximum time of 0 days, 12 hours, 00 mins, 00 secs
#SBATCH --nodes=1            # Request N nodes
#SBATCH --ntasks-per-node=10 # Request n cores or task per node
#SBATCH --mem-per-cpu=4000   # Request 4000MB (4GB) RAM per core


echo " Chargement des modules pour l'execution du calcul"

               # will list modules loaded by default.
module load GCC/11.2.0
module load mpich/ge/gcc/64/3.3.2  
module load  openmpi/gcc/64/1.10.7
module list  

echo " Creation d'espace de travail /data/$USER/Workdir/Fortran_${SLURM_JOB_ID}" 

export WORK_DIR=/data/$USER/workdir/Fortran_${SLURM_JOB_ID}
mkdir -p $WORK_DIR

export INPUT_DIR=$PWD/input
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

echo "Compiling"

mpifort -o hello_world_f hello_world.f90

echo "Running"

mpirun -np $SLURM_NTASKS hello_world_f

echo "Done"

