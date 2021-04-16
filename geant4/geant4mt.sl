
#!/bin/bash
#SBATCH -J Geant_OMP
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
module load geant4/gcc/64/mt-4.10.02.p03
module load cmake/gcc/64
#module load xerces-c/gcc/64
module load root/gcc/64



# set OMP_NUM_THREADS
    if [ -n "$SLURM_CPUS_PER_TASK" ]; then
      omp_threads=$SLURM_CPUS_PER_TASK
    else
      omp_threads=1
    fi
export OMP_NUM_THREADS=$omp_threads

#prepare working directory 
export WORK_DIR=/data/$USER/geant4_$SLURM_JOB_ID
export INPUT_DIR=$PWD/exemple

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -r $INPUT_DIR $WORK_DIR

echo "Running geant4 muti thread mode with threads $OMP_NUM_THREADS in $WORK_DIR"
cd WORK_DIR
mkdir build
cd build
cmake  ../exemple
make
./exemple -m main.mac > log.out
echo "Done"
