#!/bin/bash
#SBATCH -J R_run
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module load R

export R_LIBS=/data/$USER/myLibs/R_LIBS

echo "Running R commands  "

R < commands.R --no-save

echo "Done "
