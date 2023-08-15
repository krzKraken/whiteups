#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
grayColour="\e[0;37m\033[1m"
endColour="\033[0m\e[0m"

# Control-C handler
function ctrl_c(){
    echo -e "${redColour}[!] Exiting...${endColour}"
    tput cnorm; exit 0
}

trap ctrl_c SIGINT

# Find hosts in a given network
function find_hosts(){
    tput civis
    router_ip=$(ip route | grep default | awk '{print $3}')
    ip=${router_ip%.*}
    
    for host in $(seq 1 254); do
        timeout 1 bash -c "(ping -c 1 $ip.$host)" &> /dev/null && echo -e "${grayColour}[+] Host ${endColour}${greenColour}$ip.$host${endColour}${grayColour} is up" &
    done
}

find_hosts
#
wait
tput cnorm