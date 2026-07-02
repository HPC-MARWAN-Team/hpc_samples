## Installation de phits
Phits nécessite une licence propre à l'utilisateur . celui ci est invité à installer l 'application sur son espace home personnel .
les étapes générales d'installation sont décrite ci dessous 

### Installation de intel oneAPI 2025
Telechager la version disponible depuis le site officiel de intel https://www.intel.com/content/www/us/en/developer/articles/tool/oneapi-archive.html ,  exemple de verison 
```
wget https://registrationcenter-download.intel.com/akdlm/IRC_NAS/6caa93ca-e10a-4cc5-b210-68f385feea9e/intel-oneapi-base-toolkit-2025.3.1.36_offline.sh 
```
lancer l installation 
```
sh intel-oneapi-hpc-toolkit-2025.3.1.36_offline.sh

```
une fois terminée , charger intel : 
```
source /home/username/intel/oneapi/setvars.sh
```
et vérifier la présence du compilateur et framework mpi  
```
which mpiifx
which mpirun 
```

### Installation de phits 
Télécharger le code source fourni avec votre licence et le placer dans votre home  , puis se placer dans le dossier src 
```
cd  /home/username/phits/src 


```

modifier le makefile pour choisir le compilateur Intel et activer MPI et OpenMP . ci dessous les lignes à modifier 

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
puis lancer la compilation

```

make 
```
 une fois la compilation terminé , un exceutable est généré dans le dossier parent 
```
ls /home/username/phits/phits_LinIfort_OMP_MPI
```

### Lancer votre calcul 

préparer votre input dans un dossier input et y créer le fichier  phits.in pointant vers un fichier inp 
```
cat phits.in 

file = ParticleTherapy.inp

```
 modifier le fichier inp pour pointer vers le chemin dun dossier d installation   au niveau de la varibale file(1) 
  >    file(1)  = /home/username/phits        # (D=c:/phits) PHITS install folder name



puis lancer votre calcul avec slurm .

un exemple de script est disponible sur https://github.com/HPC-MARWAN/hpc_samples/blob/master/phits/script.sl
