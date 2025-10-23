### Lancer ARB en mode Interactif 

Vu le fait que l’application ARB fonctionne en mode graphique, il faut d'abord réserver un nœud de calcul libre et s'y connecter en mode X forwading . ci dessous les étapes nécessaires : 
```
$salloc -n1 
```
Cette commande permet l’allocation d’un nœud de calcul libre . par défaut , il sera alloué pour une durée de 2 heure (partition defq), changer  la partition avec l’option « -p » selon la durée estimée du calcul 
```
srun --pty bash -i

```
une fois connecté au nœud , charger les modules nécessaires pour le lancement de l’application ARB : 
```
$module load xerces-c/gcc/64/3.2.2
$module load ARB/gcc/18314
```
Puis lancer l’application 
```
$arb
```
 fermer la session à la fin du calcul pour libérer les ressources : 
```
$exit
```


