#!/bin/bash
#SBATCH -J DOS
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

export WORK_DIR=/data/$USER/AkaiXXXX # remplacer XXXX par l'identifiant du job de step1

cd $WORK_DIR

echo "Lancement de DOS  at $WORK_DIR"

./specx<Test.inp>dos.out

echo " Termine "
