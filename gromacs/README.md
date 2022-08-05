### Parallelization schemes 

Pour obtenir une meuilleure performance de l'application Gromacs ( l'outil mdrun ) , l'utilisateur est invité a consulter la documentation officielle sur : 

https://manual.gromacs.org/documentation/current/user-guide/mdrun-performance.html 

L'utilisateur peux tester plusieurs options de parallelisme  en spécifiant la partition **defq** un **temps de calcul** réduit (15 min par exemple )  : 

```
#SBATCH --partition=defq
#SBATCH --time=0-00:15:00
```

puis comparer l'avancement de chaque configuration  ( nombre de steps atteint , date de fin estimée )  afin  choisir le mode de parallélisme  optimal pour son  calcul  .

Exemples de tests Avec le script [gromacs_1NxMyT.sl](gromacs_1NxMyT.sl) fournit en exemple :

```
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=X
#SBATCH --cpus-per-task=Y
```

le choix de X et Y se traduit en option ntmpi et ntomp de mrdun sur la commande 

gmx mdrun -ntmpi $SLURM_TASKS_PER_NODE -ntomp $SLURM_CPUS_PER_TASK -v -deffnm md_0_10


| X  | Y  | Commandes                    | 
| ---| ---| -----------------------------| 
| 1  | 32 | gmx mdrun -ntmpi 1 -ntomp 32 |
| 2  | 16 | gmx mdrun -ntmpi 2 -ntomp 16 |
| 4  | 8  | gmx mdrun -ntmpi 4 -ntomp 8  | 
| 8  | 4  | gmx mdrun -ntmpi 8 -ntomp 4  | 



