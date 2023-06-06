#/bin/bash

function ctrl_c () {
  echo -e "\n\n[+] Exiting...!!\n"
  exit 1
}

trap ctrl_c SIGINT

declare -a ports=( $(seq 1 65535) )


function checkPort(){
  #(exec 3<> /dev/tcp/$1/$2) 2>/dev/null
  host=$1
  echo >/dev/tcp/"$host"/"$2" 2>/dev/null && echo -e "\n[+] HOST $host - Port $2 OPEN" || echo "Cerrado \n"
}


if [[ $1 ]]; then
  for port in ${ports[@]}; do 
    checkPort $1 $port &
  done
else
  echo -e "\n[!] Use example\n"
  echo -e "$0 <ip-address>"
fi

wait




