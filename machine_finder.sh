#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Variables Globales
main_url="https://htbmachins.hithub.io/bundle.js"


# Handle error
function ctrl_c(){
 echo -e "${redColour}\n\n[+] Saliendo...${endColour}"
  tput cnorm;exit 1
}

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}Uso:\n"
  echo -e "\t${purpleColour}u)${endColour} Descargar o Actualizar archivos necesarios"
  echo -e "\t${purpleColour}m)${endColour} Buscar por Nombre de Maquina."
  echo -e "\t${purpleColour}h)${endColour} Mostrar este panel de ayuda."
}

function searchMachine(){
  echo "$1"
}

val="$(cat bundle.js; echo $?)"
echo "$val"

function updateFiles (){
 if [ "$]; do
   echo "Archivo existe"
 else
   echo "Archivo no Existe"    

#curl -s $"main_url" > bundle.js

}

# Indicadores
declare -i parameter_counter=0


trap ctrl_c INT

while getopts "m:uh" arg; do
case $arg in
  m) machine_name=$OPTARG ;let parameter_counter+=1;;
  u) let parameter_counter+=2;;
  h);;
esac
done

if [ $parameter_counter -eq 1 ]; then
  searchMachine $machine_name
elif [ $parameter_counter -eq 2 ]; then
  updateFiles
else
  helpPanel
fi

