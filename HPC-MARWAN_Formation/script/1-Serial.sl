#!/bin/bash
#SBATCH -J TestSerie
#SBATCH --partition=demoq#partition de test 
#SBATCH --account=marwan
#SBATCH -t 00:01:00 
#SBATCH -o TestSerie-%j.out
#SBATCH -e TestSerie-%j.err

echo "pause pour 59 second"

sleep 59

echo "mon premier job sur la machine  `hostname`"

echo "termine "
