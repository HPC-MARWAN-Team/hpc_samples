### Parallelization schemes 

Pour obtenir une meuilleure performance de l'application Gromacs ( l'outil mdrun ) , l'utilisateur est invité a consulter la documentation officielle sur : 

https://manual.gromacs.org/documentation/current/user-guide/mdrun-performance.html 

L'utilisateur peux tester plusieurs options de parallelisme  en spécifiant la partition **defq** un **temps de calcul** réduit (15 min par exemple )  : 

```
#SBATCH --partition=defq
#SBATCH --time=0-00:15:00
```

puis comparer l'avancement de chaque configuration  ( nombre de steps atteint , date de fin estimée )  afin  choisir le mode de parallélisme  optimal pour son  calcul  . 








