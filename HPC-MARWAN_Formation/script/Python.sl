#!/bin/bash
#SBATCH --job-name=TestPython
#SBATCH --partition=demoq     #partition de test limitée 
#SBATCH --account=marwan
#SBATCH -n 8
#SBATCH -o %x-%j.out #messages de log
#SBATCH -e %x-%j.err #messages d'erreurs


module load Python/3.9.6-GCCcore-11.2.0-bare
module list


export WORK_DIR=$PWD/../workdir/Python_${SLURM_JOB_ID}

export INPUT_DIR=$PWD/../input/Python

#creation de l espace de travail 
echo " Creation d'espace de travail $WORK_DIR"
mkdir -p $WORK_DIR

#copier les inputs dans le dossier de travail 
cp -R $INPUT_DIR/* $WORK_DIR

cd $WORK_DIR
python --version

 


echo "Running "

python Python.py

echo "Done"
