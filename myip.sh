#!/usr/bin/bash
#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


# Tenemos varias formas de filtrar o recortar outputs
# Una de ellas es usando
# tail -n 1 -> Filtra por la ultima linea
# awk '{print $2}' 'FS=/' -> toma el segundo campo separado por '/'
# cut -d '/' -f 1 -> Divide por e delimitador '/' y toma el primer field

echo -e "${yellowColour}[+]${endColour} ${blueColour}Tu IP es: ${endColour} ${redColour}$(/usr/sbin/ip a | grep eth0 | awk 'NR==2' | awk '{print $2}' | cut -d '/' -f 1)${endColour}"
echo -e "\n[+] Tu Ip con otros comandos: \n $(/usr/sbin/ip a | grep eth0 | grep "inet " | awk '{print $2}' | tr '/' ' ' | awk '{print $1}') "
