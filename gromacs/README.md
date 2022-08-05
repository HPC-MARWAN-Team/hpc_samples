### Parallelization schemes 

Veuillez consulter la documentation officielle sur :     https://manual.gromacs.org/documentation/current/user-guide/mdrun-performance.html 

Pour ce faire , l'utilisateur est invité à lancer plusieurs tests avec plusieurs options de parallelisme  en spécifiant un **walltime** réduit (15 min par exemple )  : 

```
#SBATCH --partition=defq
#SBATCH --time=0-00:15:00
```

puis comparer l'avancement de chaque test ( nombre de steps atteint , date de fin estimée )  

afin  choisir le mode de parallélisme  optimal pour son  calcul  . 








