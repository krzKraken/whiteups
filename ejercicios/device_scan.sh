#!/bin/bash

# Variables Globales



function ctrl_c(){
  echo -e "\n\n [!] Saliendo..."
  tput cnorm; exit 1
}

function wich_lan(){
 lan=$(echo $(ip a | grep ens33 | tail -n 1 | awk '{print $2}' | cut -d '/' -f 1 | tr '.' '\n' | head -n 3 | tr '\n' '.' )"x" )
 echo "$lan"
}

#Ctrl+c
trap ctrl_c INT


echo -e "\n[!] Iniciando Escaneo de Dispositivos en la red: \n"
echo -e "\n[!] Buscando en rango de red:"
wich_lan

tput civis #-> Oculta el Cursor
for i in $(seq 1 254); do
  (timeout 1 bash -c "ping -c 1 192.168.100.$i") &>/dev/null && echo "Dispositivo en la Ip: 192.168.1.$i - Activo" &
done; wait
tput cnorm # -> Recupera el cursorwq
