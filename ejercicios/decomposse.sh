#!/bin/bash

function ctrl_c(){
  echo -e "\n\n [!] Saliendo...\n"
  exit 1
  }


#Control C
trap ctrl_c INT

compressed_file_name="$1"

decompressed_file_name="$(7z l data.gz | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"
echo $decompressed_file_name


7z x $compressed_file_name &>/dev/null

while [ $decompressed_file_name ]; do
  echo -e "\n[+] Descomprimido el Archivo: $decompressed_file_name \n"
  7z x $decompressed_file_name &>/dev/null
  decompressed_file_name="$(7z l $decompressed_file_name 2>/dev/null | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"
done



