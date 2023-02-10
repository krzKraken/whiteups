#!/bin/bash

function ctrl_c(){
  echo -e "\n\n [!] Saliendo..."
  tput cnorm; exit 1
}

#Ctrl+c
trap ctrl_c INT

echo -e "\n[!] Iniciando Escaneo de Dispositivos..\n"


tput civis #-> Oculta el Cursor
for i in $(seq 1 254); do
  (timeout 1 bash -c "ping -c 1 192.168.100.$i") &>/dev/null && echo "Dispositivo en la Ip: 192.168.100.$i - Activo" &
done; wait
tput cnorm # -> Recupera el cursorwq
