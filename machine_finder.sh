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
main_url="https://htbmachines.github.io/bundle.js"


# Handle error
ctrl_c(){
 echo -e "${redColour}\n\n[+] Saliendo...${endColour}"
  tput cnorm && exit 1
}

helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}Uso:\n"
  echo -e "\t${purpleColour}u)${endColour} Descargar o Actualizar archivos necesarios"
  echo -e "\t${purpleColour}m)${endColour} Buscar por Nombre de Maquina."
  echo -e "\t${purpleColour}h)${endColour} Mostrar este panel de ayuda."
}

searchMachine(){
  machine_name="$1"
  echo -e "${yellowColour}[+]${endColour}${greenColour} Buscando coincidencias para: $machine_name${endColour} \n"
  cat bundle.js | awk "/name: \"Tentacle\"/,/resuelta:/" | grep -vE "id|sku" | sed "s/^ *//"
}

updateFiles (){
  
  if [ ! -f bundle.js ];then
    tput civis
    echo -e "\n${yellowColour}[+]${endColour}${greenColour} Descargando archivos necesarios..${endColour}"
    curl -s $main_url > bundle.js
    js-beautify bundle.js | sponge bundle.js
    echo -e "\n${yellowColour}[+]${endColour}${greenColour} Todos los archivos se cargaron correctamente ${endColour}${redColour}:)${endColour}"
    tput cnorm
  else
    tput civis
    echo -e "\n${yellowColour}[!]${endColour}${greenColour}Verificando Archivos...${endColour}"
    curl -s $main_url > bundle_temp.js
    js-beautify bundle_temp.js | sponge bundle_temp.js
    md5sum_original_value="$(md5sum bundle.js | awk '{print $1}')"
    md5sum_temp_value="$(md5sum bundle_temp.js | awk '{print $1}')"
    tput cnorm
    if [ "$md5sum_original_value" == "$md5sum_temp_value" ]; then
      echo -e "\n${yellowColour}[+]${endColour}${greenColour} No Hay actualizaciones disponibles...${endColour}"
      rm bundle_temp.js
    else
      echo -e "\n${yellowColour}[+]${endColour}${greenColour} Actualizando archivos...${endColour}"
      rm bundle.js; mv bundle_temp.js bundle.js
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Todos los archivos se han actualizado correctamente.${endColour}"
    fi
  fi
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

