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
  echo -e "\t${blueColour}t)${endColour} ${grayColour}Tecnica para jugar ${endColour} ${purpleColour}(martingal/inverseLabrouchere)${endColour}\n"
  exit 1
}

function martingala(){
  echo -e "${yellowColour}[+]${endColour} Vamos a Jugar con ${blueColour}$technique${endColour}\n"
  echo -e "${yellowColour}[+]${endColour} Dinero disponible: \$${greenColour}$money${endColour}"
  echo -ne "${yellowColour}[+]${endColour} Cuanto dinero quieres empezar apostando? -> " && read initial_bet
  echo -ne "${yellowColour}[+]${endColour} A que deseas apostar continuamente (par/impar)? -> " && read par_impar
  echo -e "${endColour}[+]${endColour}\nVamos a apostar ${greenColour}\$$initial_bet${endColour} a ${greenColour}$par_impar${endColour}\n"

  backup_bet=$initial_bet
  contador_jugadas=1
  jugadas_malas="[ "
  max_ganado=$money
  tput civis
  while true; do
    money=$(($money-$initial_bet))
#    echo -e "\n[+] Acabas de apostar ${yellowColour}$initial_bet${endColour} y tienes ${greenColour}$money${endColour}"    
    random_number=$(($RANDOM % 37))
#    echo -e "\n${yellowColour}[+]${endColour} Ha salido el numero: $random_number"
    if [ $money -gt 0 ]; then
      #Toda esta definicion es para apuestas a pares
      if [ "$par_impar" == "par" ]; then
        if [ $((random_number)) -eq 0 ]; then
#          echo -e "${yellowColour}[+]${endColour} Ha salido 0, ${redColour}Pierdes!${endColour}\n"
          initial_bet=$(($initial_bet*2))
          jugadas_malas+="$random_number "
#          echo -e "${yellowColour}[!]${endColour} Te queda ${redColour}$money${endColour}"


        elif [ $((random_number % 2)) -eq 0 ] ; then
#          echo -e "${yellowColour}[+]${endColour} Ha salido Par, ${greenColour}Ganas!${endColour}"
          reward=$((initial_bet*2))
          money=$(($money+$reward))
#          echo -e "${yellowColour}[+]${endColour} Tienes ${greenColour}$money${endColour}"
          initial_bet=$backup_bet
          jugadas_malas=""
          if [ $money -gt $max_ganado ];then
            max_ganado=$money
          fi

        else
#          echo -e "${yellowColour}[+]${endColour} Ha salido Impar, ${redColour}Pierdes!${endColour}"
          initial_bet=$((initial_bet*2))
          jugadas_malas+="$random_number "
#          echo -e "${yellowColour}[!]${endColour} Te queda ${redColour}$money${endColour}"
        fi
      elif [ "$par_impar" == "impar" ]; then
        if [ $((random_number)) -eq 0 ]; then
#          echo -e "${yellowColour}[+]${endColour} Ha salido 0, ${redColour}Pierdes!${endColour}\n"
          initial_bet=$(($initial_bet*2))
          jugadas_malas+="$random_number "
#          echo -e "${yellowColour}[!]${endColour} Te queda ${redColour}$money${endColour}"


        elif [ ! $((random_number % 2)) -eq 0 ] ; then
#          echo -e "${yellowColour}[+]${endColour} Ha salido impar, ${greenColour}Ganas!${endColour}"
          reward=$((initial_bet*2))
          money=$(($money+$reward))
#          echo -e "${yellowColour}[+]${endColour} Tienes ${greenColour}$money${endColour}"
          initial_bet=$backup_bet
          jugadas_malas=""
          if [ $money -gt $max_ganado ];then
            max_ganado=$money
          fi

        else
#          echo -e "${yellowColour}[+]${endColour} Ha salido Impar, ${redColour}Pierdes!${endColour}"
          initial_bet=$((initial_bet*2))
          jugadas_malas+="$random_number "
#          echo -e "${yellowColour}[!]${endColour} Te queda ${redColour}$money${endColour}"
        fi
 
      fi
    else
      echo -e "${redColour}[!] Te has quedado sin dinero${endColour}"
      echo -e "${yellowColour}[+]${endColour} Han habido un total de ${greenColour}$contador_jugadas${endColour} jugadas"
      echo -e "${yellowColour}[+]${endColour} Las jugadas malas son: "
      echo -e "${blueColour}$jugadas_malas${endColour}"
      echo -e "${greenColour}[+] El maximo ganado fue: $max_ganado ${endColour}"
      tput cnorm; exit 1
    fi
    let contador_jugadas+=1
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

