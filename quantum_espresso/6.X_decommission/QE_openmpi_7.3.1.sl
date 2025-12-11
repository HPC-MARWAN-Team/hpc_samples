
#!/bin/bash
#SBATCH -J QE731
#SBATCH --ntasks=8
#SBATCH --ntasks-per-core=16
#SBATCH --partition=defq
##SBATCH --mem-per-cpu=10G   # la taille de mémoire par cpu que vous estimez nécessaire pour votre calcul.
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


#load qe

module load QuantumESPRESSO/7.3.1-foss-2023a
export OMP_NUM_THREADS=1

#prepare work dir
export WORK_DIR=$PWD/Qe_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

export ESPRESSO_PSEUDO=$PWD/pseudo
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#run
echo "Running Quantum Espresso with $SLURM_NTASKS at $WORK_DIR"

mpirun -np $SLURM_NTASKS pw.x -i test.in > test.out

echo "Done"
