Créer un dossier dans votre dossier personel sur /home pour y déposer les librairies R dont vous avez besoin :
```
mkdir -p /home/$USER/myLibs/R_LIBS
```
déclarer la variable R_LIBS pour 
```
export R_LIBS=/home/$USER/myLibs/R_LIBS
```
Installer les libraries nécassaire à votre calcul via la job install.sl en spécifiant la liste les commandes d'installation dans un fichier R ( exemple : installPackages.R )

```
sbatch install.sl
```

une fois le job d'installation terminé , vous pouvez lancer votre job de traitement de donées avec le script slurm   run.sl en spécifiant les commandes de traitement  dans un fichier R ( exemple : commands.R) 

```
sbatch run.sl
```
