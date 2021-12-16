#!/bin/bash
#SBATCH -J GamosOnUbuntu
#SBATCH --partition=shortq
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err


module load singularity
module load gamos/ubuntu18/6.2

#prepare working dir
export WORK_DIR=/data/$USER/gamos${SLURM_JOB_ID}
export INPUT_DIR=$PWD/myInput

[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }


mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cp $PWD/rungamos.sh $WORK_DIR/
cd $WORK_DIR

echo "Running Gamos  at $WORK_DIR"
chmod +x rungamos.sh
singularity exec --bind $PWD:/mnt $GAMOS62_IMG /mnt/rungamos.sh exercise0a.in

echo "Done"
