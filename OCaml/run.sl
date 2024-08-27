#!/bin/bash
#SBATCH --job-name=OCamltest
#SBATCH -p demoq            # Submit to 'defq' Partitiion
#SBATCH --constraint=ib 
#SBATCH --ntasks=10 # Request n cores or task 
#SBATCH --mem-per-cpu=4000   # Request 4000MB (4GB) RAM per core
#SBATCH -o OCamltest-%j.out   # Write the standard output to file named 'OCamltest-<job_number>.out'
#SBATCH -e OCamltest-%j.err   # Write the standard error to file named 'OCamltest-<job_number>.err'

echo " Chargement des modules pour l'execution du calcul"

               # will list modules loaded by default.
			   
module load OCaml/4.14.0-GCC-11.3.0
module list  


echo " Creation d'espace de travail /scratch/users/$USER/Workdir/OCaml_${SLURM_JOB_ID}" 

export WORK_DIR=/scratch/users/$USER/workdir/OCaml_${SLURM_JOB_ID}
mkdir -p $WORK_DIR

export INPUT_DIR=$PWD/input
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

echo " compiling the job" 

ocamlc -thread -o test unix.cma threads.cma test.ml


echo " running the job" 

./test
