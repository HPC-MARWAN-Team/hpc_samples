#!/bin/bash
#SBATCH -J Geant4
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules
module load geant4/gcc/64/4.10.05
module load cmake/gcc/64

#prepare work_dir
export WORK_DIR=/data/$USER/geant4_$SLURM_JOB_ID
export INPUT_DIR=$PWD/B5

[[ -z $INPUT_DIR ]] && { echo "Error: Dossier Input non spécifié "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error: Dossier Input n'existe pas "; exit 1; }

mkdir -p $WORK_DIR
cp -r $INPUT_DIR $WORK_DIR

echo "Running geant4 in $WORK_DIR"

cd $WORK_DIR
mkdir build
cd build
cmake  ../B5
make
./exampleB5 exampleB5.in > exampleB5.out
echo "Done"
