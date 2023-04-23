#!/bin/bash

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
bold="\e[1m"
underline="\e[4m"

#ctrl_c SIG
function ctrl_c() {
    echo -e "${redColour}\n\n[!] ${bold}Saliendo...${endColour}\n"
    echo -e "\n${underline}${bold} [+] Status code $(echo $?)${endColour}"
    echo -e "\n El ultima linea"
    tput cnorm; exit 1
    
}


trap ctrl_c SIGINT


sleep 5
tput cnorm