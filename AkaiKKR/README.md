######  Lancer le script go 
```
sbatch specx_go.sl
```
######  un dossier de travail sera créer  qui contiendra les outputs (par exemple /home/$USER/Akai1234 ) 

######  il faut pointer sur celui ci pour la deuxième étape , il suffit de modifier le script specx_dos.sl en changeant la variable WORK_DIR pour spécifier le chemin du dossier crée lors de la soumission du script go 


> export WORK_DIR=/home/$USER/Akai1234 


avant de le lancer : 
```
sbatch specx_dos.sl
```
