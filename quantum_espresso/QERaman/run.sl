#!/bin/bash
#SBATCH -J QERaman_intel #jobname
#SBATCH --ntasks=16 #number of cpus 
#SBATCH --ntasks-per-core=4
#SBATCH --partition=mediumq #partition depending on job duration
#SBATCH --mem-per-cpu=10G   # la taille de mémoire par cpu que vous estimez nécessaire pour votre calcul.
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules

module load intel2021/mpi intel2021/mkl intel2021/compiler OpenMPI/4.1.4-GCC-12.2.0 

module load QERaman/intel/qe7.2

#prepare working directory 
export WORK_DIR=/scratch/users/$USER/workdir/QERaman_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input
[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

export ESPRESSO_PSEUDO=/$PDW/pseudo

export OMP_NUM_THREADS=1

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR


echo "Running QERaman with $SLURM_NTASKS at $WORK_DIR"

echo "Running pw.x"

mpirun -np $SLURM_NTASKS pw.x -i P.scf.in > P.scf.out

echo "Running bands_mat.x "
mpirun -np $SLURM_NTASKS bands_mat.x -i bands.in> bands.out

echo "Running ph_mat.x"
mpirun -np $SLURM_NTASKS ph_mat.x -i ph.in> ph.out

echo "Running raman.x"
raman.x -i raman.in> raman.out

echo "Done"
