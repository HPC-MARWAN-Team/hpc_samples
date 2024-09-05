#!/bin/bash
#SBATCH --job-name=STAR_smp_test
#SBATCH --ntasks=20
#SBATCH --ntasks-per-core=1
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
#SBATCH --time=10:00:00


#load STAR

module load STAR/2.7.11b-GCC-13.2.0

#prepare work dir
export WORK_DIR=/scratch/users/$USER/workdir/STAR_${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }


mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR

#=====================================================#
# Assign varialbles
#=====================================================#

#--| PATH

export genom_dir=$WORK_DIR/index
mkdir -p $genom_dir

#--| FILE
export finput=$WORK_DIR/GRCm38.primary_assembly.genome.fasta
export annotation=$WORK_DIR/gencode.vM25.annotation.gtf


#run
echo "Running STAR with $SLURM_NTASKS at $WORK_DIR"

STAR --runThreadN $SLURM_NTASKS --runMode genomeGenerate --genomeDir $genom_dir --genomeFastaFiles $finput --sjdbGTFfile $annotation --sjdbOverhang 100



echo "Done"
