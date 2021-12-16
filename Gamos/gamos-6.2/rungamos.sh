#!/bin/bash

#Gamos PATH inside Singularity image
export GAMOSINSTALL=/opt/Gamos-6.2/GAMOS.6.2.0
source $GAMOSINSTALL/config/confgamos.sh
#run script
cd /mnt
gamos $1
