#!/bin/bash
#SBATCH -J phits
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=2
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


#intel for mpirun
source /home/$USER/intel/oneapi/setvars.sh
#phits path
export phits_exe=/home/$USER/phits/phits_LinIfort_OMP_MPI

# set OMP_NUM_THREADS
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
      omp_threads=$SLURM_CPUS_PER_TASK
else
      omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

#prepare work dir
export WORK_DIR=$PWD/Ph_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR
echo "Running phits with $SLURM_NTASKS and $OMP_NUM_THREADS threads at $WORK_DIR"

mpirun -np $SLURM_NTASKS $phits_exe

echo "Done"
