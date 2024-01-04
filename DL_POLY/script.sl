#!/bin/bash
#SBATCH --job-name=DL-POLY-1
#SBATCH --partition=shortq #partition de test limitée a 24h, changer à mediumq ou longq selon durée estimée
#SBATCH -o DLPOLY-%j.out #messages de log
#SBATCH -e DLPOLY-%j.err #messages d'erreurs


module load DL_POLY_4/5.0.0-foss-2020b


echo " Creation d'espace de travail /data/$USER/workdir/DLPOLY_${SLURM_JOB_ID}" 
export WORK_DIR=/data/$USER/workdir/DLPOLY_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/inputDLPOLY
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR

cd $WORK_DIR

echo "jusqu a 10000 trempe lente recherche du bon volume"

export REP_TRAVAIL=$WORK_DIR/PSrEu9

export REP_DONNEES=$REP_TRAVAIL/DATA

export REP_BASE=$WORK_DIR/PSrEu9

# chauffe
export  REP_CONTROL=$REP_BASE/REPCONTROL

export  REP_RESULTATS=$REP_TRAVAIL/RESULTS

cp $REP_DONNEES/CONFIG ./CONFIG

cp $REP_DONNEES/FIELD ./FIELD

date


i=0
# vous pouvez changer le nombre d'iteration de 1 au nombre que vous voulez.
while test $i -le 1 
do
cp $REP_CONTROL/CONTROL$i ./CONTROL

mpirun -np 1 DLPOLY.Z

wait

echo  "DLPOLY Termine pour iteration $i"

echo "list fichier `ls -l`" 

echo  "Recuperation des resultats"
# Recuperation des resultats :
# OUTPUT
#
  if test -f OUTPUT
  then
    mv OUTPUT $REP_RESULTATS/OUTPUT.$i
  fi

# HISTORY
#
  if test -f HISTORY
  then
    mv HISTORY $REP_RESULTATS/HISTORY.$i
  fi

  if test -f RDFDAT 
  then
    mv RDFDAT $REP_RESULTATS/RDFDAT.$i
  fi


cp CONFIG $REP_RESULTATS/CONFIG.$i
mv CONFIG CONFIG.OLD
mv REVCON CONFIG
mv REVIVE REVOLD


i=`expr $i + 1`
date
done
cp STATIS $REP_RESULTATS/STATIS
echo  "DONE"
