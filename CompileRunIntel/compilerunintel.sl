#!/bin/bash
#SBATCH -J MyCode
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
#SBATCH --partition=shortq

module load intel2021/compiler


#prepare work_dir
export WORK_DIR=/data/$USER/workdir
export INPUT_DIR=$PWD/code_and_input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }

mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

echo "Running code on $WORK_DIR"
ifort -o myfortran.out myfortrancode.f
chmod +x myfortran.out
./myfortran.out

echo "Done"
