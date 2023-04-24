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
    echo -e "${redColour}\n\n[!] ${bold}Exiting...${endColour}\n"
    exit 1
    
}

trap ctrl_c SIGINT

# Declare Array
declare -a ports=( $(seq 1 65535) )

#function to prompt the user with a yes/no question
function ask_yes_no {
    while true; do
        read -p "$1 [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}


function checkPort(){
    #check if port is open
    # 0 -> successed
    # 1 -> failed
    nc -zv -w 2 $1 $2 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "\n${greenColour}[+] Port $2 is open! ${endColour}"
    fi
    sleep 0.10
}


#check if requirements are isntalled
if ! command -v netcat > /dev/null; then
    echo -e "${redColour}[!] Netcat is not installed! ${endColour} \n"
    if ask_yes_no "[?] Do you want to install netcat? "; then
        # Install curl
        # sudo apt-get update
        #parrot OS
        sudo apt parrot-upgrade
        sudo apt install -y netcat
        echo -e "${greenColour}[+] Tools installed successfully! ${endColour}"
    else
        echo -e "${redColour}[!] Netcat needed! ${endColour} \n"
        exit 1
    fi
    
fi

echo -e "${greenColour}[+] Tools needed already installed ${endColour}"

if [ $1 ]; then
    host=($1)
    for port in ${ports[@]}; do
        checkPort $host $port &
    done
else
    echo -e "${yellowColour}[?] Use $0 <ip-address> ${endColour}"
fi

wait