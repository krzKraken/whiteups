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

# Array of possible ports
declare -a possible_ports=( $(seq 1 65535) )


function ctrl_c(){
    echo -e "\n\n ${redColour}${bold}[!] Exiting...${endColour}\n"
    tput cnorm; exit 1
}
# Ctrl + C
trap ctrl_c SIGINT

function is_port_open(){
    # This function check the stderr and the stdout of a port using (echo '' > /dev/tcp/<ip>/<port>) 3>/dev/null
    timeout 0.5 bash -c "(exec 3<> /dev/tcp/$1/$2) 2>/dev/null"
    
    if [ $? -eq 0 ]; then
        echo -e "Host: ${greenColour}$1${endColour}, Port: ${greenColour}$2${endColour} is open"
    fi
    exec 3>&-
    exec 3<&-
    
    
}

tput civis

if [ $1 ]; then
    tput civis
    for port in ${possible_ports[@]}; do
        echo -ne "Analizing port $port/65535\r"
        is_port_open $1 $port &
    done
else
    echo -e "\n${blueColour}[?] USE:${endColour} \n"
    echo -e "   ${grayColour}$0 <ip-address> \n\n${endColour}"
fi

wait
tput cnorm
