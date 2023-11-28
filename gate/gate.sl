#!/bin/bash
#SBATCH -J Gate9.0
#SBATCH --partition=shortq
#SBATCH --constraint=opa
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load modules 

 module load gate-9.0-gcc-10.2.0-jyekk37

#prepare working dir
export WORK_DIR=/data/$USER/gate_$SLURM_JOB_ID

mkdir -p $WORK_DIR
cp $PWD/benchPET/* $WORK_DIR
cp $PWD/GateMaterials.db $WORK_DIR/
echo "Running gate in $WORK_DIR"

cd $WORK_DIR

echo "Running Gate in $WORK_DIR"

Gate benchPET.mac
root -b -q benchmarkPET.C

echo "Done"

