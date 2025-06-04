#!/bin/bash
#SBATCH -J QE
#SBATCH --ntasks=16
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq
#SBATCH --mem-per-cpu=10G   # la taille de mémoire par cpu que vous estimez nécessaire pour votre calcul.
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load QuantumESPRESSO with rism implementation provided by  otanui 
# https://www2.ccs.tsukuba.ac.jp/public/otani/en/programs.html

module load QuantumESPRESSO/gcc/6.7-otani-rism
export OMP_NUM_THREADS=1

#prepare work dir
export WORK_DIR=/home/$USER/Qe${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

export ESPRESSO_PSEUDO=/home/$USER/pseudo
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#run
echo "Running Quantum Espresso with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS pw.x -i myInputFile.in > myOutputFile.out

echo "Done"
