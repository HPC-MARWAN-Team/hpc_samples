## Guide d'Installation de phits
PHITS nécessite une licence propre à chaque utilisateur.  
L’application doit être installée dans l’espace **home personnel** de l’utilisateur.

Les étapes générales d’installation sont décrites ci-dessous.
### Installation de intel oneAPI 2025

Téléchargez la version disponible depuis le site officiel d’Intel :  
 https://www.intel.com/content/www/us/en/developer/articles/tool/oneapi-archive.html
 
Exemple de téléchargement :


```
wget https://registrationcenter-download.intel.com/akdlm/IRC_NAS/6caa93ca-e10a-4cc5-b210-68f385feea9e/intel-oneapi-base-toolkit-2025.3.1.36_offline.sh 
```

Lancez l’installation :

```
sh intel-oneapi-hpc-toolkit-2025.3.1.36_offline.sh

```

Une fois terminée, chargez l’environnement Intel :

```
source /home/username/intel/oneapi/setvars.sh
```
Vérifiez la présence du compilateur et du framework MPI :

```
which mpiifx
which mpirun 
```

### Installation de phits 
Téléchargez le code source fourni avec votre licence et placez-le dans votre home.
Ensuite, positionnez-vous dans le dossier src :

```
cd  /home/username/phits/src 


```

Modifiez le Makefile pour choisir le compilateur Intel et activer MPI et OpenMP.
Les lignes à adapter sont les suivantes :

```
### Machine Dependent variables, please set your environment
ENVFLAGS = LinIfort

### If you want to use MPI, delete # in the next line
USEMPI = true
### If you want to use OpenMP, delete # in the next line.
USEOMP = true
...
### Linux Intel Fortran (ifort)
ifeq ($(ENVFLAGS),LinIfort)
...
FC=mpiifx

```

Puis lancez la compilation :

```

make 
```
Une fois la compilation terminée, un exécutable est généré dans le dossier parent :

```
ls /home/username/phits/phits_LinIfort_OMP_MPI
```

### Lancer votre calcul 

Préparez votre input dans un dossier input et créez le fichier phits.in pointant vers un fichier .inp :

```
cat phits.in 

file = ParticleTherapy.inp

```
Préparez votre input dans un dossier input et créez le fichier phits.in pointant vers un fichier .inp :

  >    file(1)  = /home/username/phits        # (D=c:/phits) PHITS install folder name



Enfin, lancez votre calcul avec Slurm.

Un exemple de script est disponible ici : https://github.com/HPC-MARWAN-Team/hpc_samples/blob/master/phits/script.sl
