#!/bin/bash

# Colours
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

# Ctrl+c

function ctrl_c(){
    echo -e "\n\n ${redColour}${bold} [!] Exiting... ${endColour}\n"
    tput cnorm; exit 1
}

trap ctrl_c SIGINT


function find_active_hosts(){
    # This function check the stderr of a ping to a host using => timeout 2 bash -c "(ping -c 1 <ip-address>)" &>/dev/null and comparing the stderr result
    tput civis
    my_ip=$(hostname -I)
    echo -e "\n${grayColour}[+] My IP is ${endColour}${blueColour}${my_ip}${endColour}\n"
    echo -e "${grayColour}[+] Checking active hosts in: ${endColour}${blueColour}${my_ip%.*}.1/24${endColour}\n"
    
    for i in $(seq 2 254); do
        new_ip="${my_ip%.*}.$i"
        timeout 1 bash -c "(ping -c 1 $new_ip)" &>/dev/null && echo -en "${grayColour}[+] Host Activo: ${endColour}${greenColour}$new_ip${endColour}\n" &
    done
}

find_active_hosts

wait
tput cnorm

