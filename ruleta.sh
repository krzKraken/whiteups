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

# Ctrl_C

function ctrl_c (){
  echo -e "\n${yellowColour}[!]${endColour} ${greenColour}Saliendo...${endColour}\n"
  tput cnorm;exit 1
}

trap ctrl_c INT

function helpanel(){
  echo -e "\n${yellowColour}[+]${endColour} ${greenColour}Uso:${endColour} ${purpleColour}$0${endColour}\n"
  echo -e "Se requiere ingresar ambos parametros para jugar ${blueColour}(-m y -t)${endColour}\n"
  echo -e "\t${blueColour}m)${endColour} ${grayColour}Cantidad de Dinero para jugar.${endColour}"
  echo -e "\t${blueColour}t)${endColour} ${grayColour}Tecnica para jugar.${endColour}\n"
  exit 1
}

function martingala(){
  echo -e "${yellowColour}[+]${endColour} Vamos a Jugar con ${blueColour}$technique${endColour}\n"
  echo -e "${yellowColour}[+]${endColour} Dinero disponible: \$${greenColour}$money${endColour}"
  echo -ne "${yellowColour}[+]${endColour} Cuanto dinero quieres empezar apostando? -> " && read initial_bet
  echo -ne "${yellowColour}[+]${endColour} A que deseas apostar continuamente (par/impar)? -> " && read par_impar

  echo -e "${endColour}[+]${endColour}\nVamos a apostar ${greenColour}\$$initial_bet${endColour} a ${greenColour}$par_impar${endColour}\n"
  tput civis
  while true; do
    random_number=$(($RANDOM % 2))
    echo -e "\n${yellowColour}[+]${endColour}Salio el numero: $random_number"
    if [ $((random_number)) -eq 0 ]; then
  echo "Perdiste"
    elif [ $((random_number % 2)) -eq 0 ] ; then
    echo "Es Par"
  else
    echo "Es impar"
  fi
    sleep 1
  done
  tput cnorm

}

function inverseLabrouchere(){
  echo -e "\n[+] Vamos a jugar con la tecnica inverseLabrouchere"
}


while getopts "m:t:h" arg; do
  case "$arg" in
    m) money=$OPTARG;; 
    t) technique=$OPTARG;;
    h) ;;
  esac
done

if [ $money ] && [ $technique ]; then
  if [ $technique == "martingala" ]; then
    martingala
  elif [ $technique == "inverseLabrouchere" ]; then
    inverseLabrouchere
  else
    echo -e "${redColour}[!] La tecnica proporcionada no existe!${endColour}"
    helpanel
  fi

else
  helpanel 
fi

