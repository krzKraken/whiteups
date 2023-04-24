#!/bin/bash

for ((i = 1; i <= 500; i++)); do
    echo -ne "Analizando el puerto $i/500\r"
    # Aquí iría el código para analizar el puerto actualS
    echo -ne "Host $1 open\r"
    sleep 1
done

echo "Análisis completado."
