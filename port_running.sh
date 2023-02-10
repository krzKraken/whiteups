#!/bin/bash

function ctrl_c(){
  echo "\n\n [!] Saliendo..."
  exit 1
}

#Ctrl+c
trap ctrl_c INT

echo "\n[+] Los puertos abiertos son los siguientes:\n"


function hex_to_dec(){
  hex="$1"
  echo "obase=10; ibase=16; $hex" | bc
}

function which_process_in_port(){
  port=$1
  echo "$(lsof -i:$port | awk '{print $1}' | xargs | awk 'NF{print $NF}')"
}

echo "$(cat /proc/net/tcp | awk '{print $2}' | cut -d ':' -f 2  | tr -d 'local_address' | xargs | tr ' ' '\n')" | sort -u| while read line; do echo "[+] Puerto $line -> $(hex_to_dec $line) -open -> Ejecutando:  $(which_process_in_port $(hex_to_dec $line) )"; done

# Agregar lsof -i: <Puerto> para conocer el nombre del proceso ejecutandose por ese puerto
