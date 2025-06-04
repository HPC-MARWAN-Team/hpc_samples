#!/bin/bash
#SBATCH -J Frogs_test
#SBATCH --partition=defq
#SBATCH --time=0-00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=4G
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

#load module
module load FROGS/3.1.0


export RESULT=/home/$USER/${SLURM_JOB_ID}

echo " Running FROGS ($FROGS_PATH) with NB_CPU =  $SLURM_NTASKS_PER_NODE and MEM=$SLURM_MEM_PER_NODE  "

sh test.sh $FROGS_PATH  $SLURM_NTASKS_PER_NODE $SLURM_MEM_PER_NODE $RESULT

echo "Job Done check logs files in `pwd` (out , err ) and outputs in  $RESULT"
