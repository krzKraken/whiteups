#!/bin/bash

function ctrl_c(){
  echo -e "\n\n [!] Saliendo..."
  exit 1
}

#Ctrl+c
trap ctrl_c INT

ip=$(ifconfig eth0 |  grep inet  | head -n 1 | awk '{print $2}')
ip="192.168.1.161"

echo -e "\n[+] Escaneando Puertos en: $ip \n"

for port in $(seq 1 65535); do
  (echo '' > /dev/tcp/"$ip"/"$port") 2>/dev/null && echo "[+] Puerto $port - OPEN" &
done; wait

echo -e "\n[+] Puertos escaneados... \n"

