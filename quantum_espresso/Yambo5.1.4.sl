#!/bin/bash
#SBATCH -J QEYambo5.1.4
#SBATCH --ntasks=20
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load libxc/5.1.5-intel-compilers-2021.2.0
module load intel2021/compiler/latest intel2021/mkl/latest intel2021/mpi/latest
module load Yambo/intel/5.1.4
module load QuantumESPRESSO/intel/7.3


export OMP_NUM_THREADS=1

#prepare work dir
export WORK_DIR=$PWD/QeY_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

export ESPRESSO_PSEUDO=$PWD/pseudo
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#run

echo "Running Yambo on $SLURM_NTASKS "

mpirun -np $SLURM_NTASKS pw.x -i hBN.scf.in > hBN.scf.out

mpirun -np $SLURM_NTASKS pw.x -i hBN.nscf.in > hBN.nscf.out

cd hBN.save

p2y

yambo

yambo -hf -gw0 p -dyson n -F gw_ppa.in
           
echo "DONE"
