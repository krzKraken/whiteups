#!/bin/bash 

# Ctrol + c For quit!
ctrl_c() {
  tput cnorm
  echo -e "\n\n[!] Exiting..\n"
  exit 1
}

tput civis

trap ctrl_c SIGINT

# host ip without last number -> 192.168.0.
host=$( route -n | awk '{print $2}' | tr '\n' ' ' | awk '{print $3}' | awk -F. 'BEGIN{OFS="."} {$NF=""; print}' )
declare -a commonPorts=(21 22 23 25 80 139 443 445 8080)

for i in $(seq 1 254); do
  for port in ${commonPorts[@]}; do 
# Ping option
#    timeout 1 bash -c "(ping -c 1 $host$i) &>/dev/null && echo '$host$i - Active'" &
# Using common ports for each host 
  #timeout 1 bash -c "(echo '' > /dev/tcp/$host$i/$port) 2>/dev/null && echo '$host$i - Active'" &
    timeout 1 bash -c "(echo '' > /dev/tcp/$host$i/$port) 2>/dev/null && echo '$host$i:$port - Active'"
  done
done


wait
tput cnorm

