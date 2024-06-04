## Demande d'ajout au groupe gpu_users
les utilisateurs qui ont besoin exploiter les cartes GPU, sont invité à envoyer une demande à l'équipe HPC-MARWAN pour les ajouter dans la liste de gpu_users.

### Créer votre  environnement Python 
Créer le dossier /home/$USER/envs pour y créer les environnements conda et déclarer son chemin via la variable CONDA_ENVS_PATH
```
$export CONDA_ENVS_PATH=/home/$USER/envs
```
Charger le module  anaconda
```
$module load Anaconda3
```
Créer un environnement en choisissant son nom ( exemple  my_env_3.6  ) avec la version de python souhaité ( exemple 3.6 )  
```
$conda create -n my_env_3.6 python=3.6
```
Activer l’environnement 
```
$source activate my_env_3.6
```
vérifier que l'envirobnnement  a bien été chargé  
```
$which python
      /home/username/envs/my_env_3.6/bin/python
```
### Installer les packages nécessaires sur la machine GPU
Allouer une heure d’accès à la machine GPU 
```
$salloc  -t 60  --gres=gpu:1  --qos=gpu --partition=gpu-testq  --account=gpu_users  
salloc: Pending job allocation 24200
salloc: job 24200 queued and waiting for resources
salloc: job 24200 has been allocated resources
salloc: Granted job allocation 24200

```
une fois l'allocation effectuée, vérifier le nom de la machine gpu réservée à l'aide de la commande squeue en utilisant l'identifiant de l'allocation . Reperer le nom de la machine au niveau la colonne NODELIST 

```
$squeue -j 24200

             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            24200 gpu-testq     bash username l  R       4:27      1 gpu52
```
Se connecter à la machine GPU pour y installer les outils nécessaires 

```
$ssh gpu52
$module load cuda11.4/toolkit/11.4.2
```
 Pour le cas du **Deep learning** , la librairie **cudnn** est déjà installé , pour l’utiliser :
```
$module load cudnn8.1-cuda11.2/8.1.1.33
```
 Installer les packages nécessaires (tensorflow par exemple) :
```
$conda install tensorflow-gpu
$conda install otherPackages
```
A la fin de l’installation, fermer la session ssh 
```              
$exit
```
et terminer l’allocation de la machine en annulant le job 
```
$scancel 24200
```
### Lancer votre calcul 
Une fois les outils nécessaires installés, créer le script de lancement du calcul souhaité, et lancer le script via la commande sbatch 
Le script doit contenir la condition suivante pour allouer le nœud GPU au job 
  >   #SBATCH --partition=gpu-testq
 
  >   #SBATCH --account=gpu_users
 
  >   #SBATCH --qos=gpu

  >   #SBATCH --gres=gpu:1
 
  

A noter que la partition **gpu-testq** est limitée à 2 heures .elle est utile pour les jobs de tests.
pour des jobs plus long, veuillez utiliser la partition **gpu-prodq** ( qui permet une durée de 7 jours max ) 

un exemple de script est disponible sur https://github.com/rahimbouchra/hpc_samples/blob/master/AnacondaGPU/run.sl
