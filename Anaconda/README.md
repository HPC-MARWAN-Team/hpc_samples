### Créer votre  environnement Python 
Créer le dossier /data/$USER/envs pour y créer les environnements conda et déclarer son chemin via la variable CONDA_ENVS_PATH
```
$export CONDA_ENVS_PATH=/data/$USER/envs
```
Charger le module  anaconda2
```
$module load anaconda2
```
Créer un environnement avec la version de python souhaité
```
$conda create -n my_env_3.6 python=3.6
```
Activer l’environnement 
```
$source activate my_env_3.6
```

```
 Installer les packages nécessaires  :
```
$conda install package1
$conda install package2


### Lancer votre calcul 

Une fois les outils nécessaires installés, créer le script de lancement du calcul souhaité 

celui ci active l'environnement précedement crée avant d executer le code python 

un exemple de script est disponible sur https://github.com/rahimbouchra/hpc_samples/blob/master/Anaconda/run.sl
