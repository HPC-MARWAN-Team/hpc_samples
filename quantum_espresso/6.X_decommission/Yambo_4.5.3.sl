#!/bin/bash
#SBATCH -J QEY
#SBATCH --ntasks=24
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH --mem-per-cpu=10G   # la taille de mémoire par cpu que vous estimez nécessaire pour votre calcul.
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


module load QuantumESPRESSO/6.6-foss-2020b
module load Yambo/gcc64/4.5.3


export OMP_NUM_THREADS=1


export WORK_DIR=$PWD/${SLURM_JOB_NAME}_${SLURM_JOB_ID}

echo "Running PW and Yambo on $SLURM_JOB_NODELIST   "

mkdir -p $WORK_DIR
cp -R $PWD/inputs  $WORK_DIR

cd $WORK_DIR

# Run a SCF calculation
mpirun -np $SLURM_NTASKS pw.x -i GeAs_GaSTe_scf.in > GeAs_GaSTe_scf_${SLURM_JOB_ID}.out
mpirun -np $SLURM_NTASKS pw.x -i GeAs_GaSTe_nscf.in > GeAs_GaSTe_nscf_${SLURM_JOB_ID}.out
echo "SCF done"

cd tmp/1layer.save
p2y

echo "DONE" 
