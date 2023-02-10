#!/bin/bash

function ctrl_c(){
  echo -e "\n\n [!] Saliendo..."
  exit 1
}

#Ctrl+c
trap ctrl_c INT

echo -e "\n[+] Escaneando Puertos... \n"

for port in $(seq 1 65535); do
  (echo '' > /dev/tcp/127.0.0.1/$port) 2>/dev/null && echo "[+] Puerto $port - OPEN" &
done; wait

echo -e "\n[+] Puertos escaneados... \n"

