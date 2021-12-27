#!/bin/bash
#SBATCH -J R_install
#SBATCH --partition=defq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load R

export R_LIBS=/data/$USER/myLibs/R_LIBS

echo "Installing packages at $R_LIBS "

R < installPackages.R --no-save

echo "Installation Done  "
