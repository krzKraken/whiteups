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
  echo -e "\t${purpleColour}i)${endColour} Buscar maquina por Ip."
  echo -e "\t${purpleColour}y)${endColour} Obtener link de la resolucion de la maquina en Youtube."
  echo -e "\t${purpleColour}d)${endColour} Listar maquinas por dificultad."
  echo -e "\t${purpleColour}o)${endColour} Buscar por Sistema Operativo"
  echo -e "\t${purpleColour}s)${endColour} Buscar por Skills."
  echo -e "\t${purpleColour}h)${endColour} Mostrar este panel de ayuda."
}

updateFiles(){
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

searchMachine(){
  machine_name="$1"
  
  machine_name_checker="$(cat bundle.js | awk "/name: \"$machine_name\"/,/resuelta:/" | grep -vE "id|sku|resuelta" | sed "s/^ *//" | tr -d ',' |tr -d '"')"
  if [ "$machine_name_checker" ]; then
    echo -e "${yellowColour}\n[+]${endColour}${greenColour} Listando propiedades para la maquina:${endColour}${redColour} $machine_name${endColour} \n"
    cat bundle.js | awk "/name: \"$machine_name\"/,/resuelta:/" | grep -vE "id|sku|resuelta" | sed "s/^ *//" | tr -d ',' |tr -d '"' | while read line; do
   echo -e "${blueColour}$(echo $line | awk '{print $1}')${endColour} ${grayColour}$(echo $line | awk '{print $2}')${endColour}";
 done 
else
   echo -e "${redColour}[!] Maquina no existe ${endColour}\n"
 fi
}

searchIp(){
  ip_address="$1"
  machineName="$(cat bundle.js | grep "ip: \"$ip_address\"" -B 5 | grep "name: " | awk 'NF{print $NF}' | tr -d ',' | tr -d '"')"
  if [ "$machineName" ]; then
    echo -e "${yellowColour}\n[+]${endColour} ${grayColour}La maquina correspondiente para la${endColour} ${blueColour}$ip_address${endColour} ${grayColour}es${endColour} ${purpleColour}$machineName${endColour}\n"
  else
    echo -e "\n${redColour}[!] Ip no existe${endColour}\n"
  fi
}

searchLink(){
  machine_name="$1"
  link="$(cat bundle.js | awk "/name: \"$machine_name\"/,/resuelta:/" | grep -vE "id|sku|resuelta" | sed "s/^ *//" | tr -d ',' | tr -d '"' | grep 'youtube' | awk 'NF{print $NF}')"
  if [ "$link" ]; then
    echo -e "\n${yellowColour}[+]${endColour}${greenColour} ${greenColour}El Link de la resolucion es:${endColour} ${blueColour}$link${endColour}"
  else
    echo -e "\n${redColour} [!] Maquina no encontrada ${endColour}"
  fi
}
searchDificult(){
  dificultad=$1
  color=""
  case "$dificultad" in
    Insane) color="${redColour}";;
    Dificil) color="${yellowColour}";;
    Medio) color="${greenColour}";;
    Facil) color="${greenColour}";;
  esac

  dificultad_value="$(cat bundle.js | grep "dificultad: \"$dificultad\"" -B 5 | grep 'name:' | awk 'NF{print $NF}'| tr -d '"'| tr -d ','| column)"
  if [ "$dificultad_value" ]; then
    echo -e "\n${yellowColour}[+]${endColour} Las maquinas con dificultad $color$dificultad ${endColour}son:\n\n$dificultad_value\n"
  else
    echo -e "\n${redColour}[!] No existe coincidencias.${endColour}"
  fi
}

searchForOS(){
  os="$1"
  os_value="$(cat bundle.js | grep "so: \"$os\"" -B 5 | grep "name: " | awk '{print $2}' | tr -d '"' | tr -d ',' |column )"
  if [ "$os_value" ]; then
    echo -e "\n${yellowColour}[+]${endColour} ${greenColour}Las Maquinas${endColour}${blueColour} $os ${endColour}${greenColour}son:${endColour}\n"
    cat bundle.js | grep "so: \"$os\"" -B 5 | grep "name: " | awk '{print $2}' | tr -d '"' | tr -d ',' |column
  else
    echo -e "\n${redColour}[!] No se encontraron coincidencias de os para $os${endColour} \n"
  fi
}

searchForSkills(){
  skill="$1"

}



# Indicadores
declare -i parameter_counter=0


trap ctrl_c INT

while getopts "m:ui:y:d:o:s:h" arg; do
case $arg in
  m) machine_name="$OPTARG"; let parameter_counter+=1;;
  u) let parameter_counter+=2;;
  i) ipAddress="$OPTARG"; let parameter_counter+=3;;
  y) machine_name="$OPTARG"; let parameter_counter+=4;;
  d) dificultad="$OPTARG"; let parameter_counter+=5;;
  o) os="$OPTARG"; let parameter_counter+=6;;
  s) skills="$OPTARG"; let parameter_counter+=7;;
  h);;
esac
done

if [ $parameter_counter -eq 1 ]; then
  searchMachine $machine_name
elif [ $parameter_counter -eq 2 ]; then
  updateFiles
elif [ $parameter_counter -eq 3 ]; then
  searchIp $ipAddress
elif [ $parameter_counter -eq 4 ]; then
  searchLink $machine_name
elif [ $parameter_counter -eq 5 ]; then
  searchDificult $dificultad
elif [ $parameter_counter -eq 6 ]; then
  searchForOS $os
elif [ $parameter_counter -eq 7 ]; then
  searchForSkills $skills
else
  helpPanel
fi

