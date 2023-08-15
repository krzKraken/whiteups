#!/bin/bash

# Function to prompt the user with a yes/no question
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

# Check if curl is installed
if ! command -v netcat > /dev/null; then
    echo "jq is not installed"
    if ask_yes_no "Do you want to install netcat?"; then
        # Install curl
        # sudo apt-get update
        #parrot OS
        sudo apt parrot-upgrade
        sudo apt install -y netcat
    fi
fi


echo "Tools installed successfully"
