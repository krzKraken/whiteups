#!/bin/bash

function ctrl_c(){
  echo -e "\n\n [!] Saliendo..."
  tput cnorm; exit 1
}

function wich_lan(){
 red=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}')
}

#Ctrl+c
trap ctrl_c INT


echo -e "\n[!] Iniciando Escaneo de Dispositivos en la red: \n"


tput civis #-> Oculta el Cursor
for i in $(seq 1 254); do
  (timeout 1 bash -c "ping -c 1 192.168.1.$i") &>/dev/null && echo "Dispositivo en la Ip: 192.168.1.$i - Activo" &
done; wait
tput cnorm # -> Recupera el cursorwq
