#!/bin/bash

# Puerto base
base_port=1088

# Leer la lista de contenedores desde containers.txt
containers=($(cat containers.txt))
total_containers=${#containers[@]}

for ((i=0; i<$total_containers; i++)); do
    container_name="${containers[$i]}"
    # Convertir el nombre del contenedor a inicial mayúscula
    container_name_upper="$(tr '[:lower:]' '[:upper:]' <<< ${container_name:0:1})${container_name:1}"

    # Modificar el archivo dentro del contenedor
    docker exec "$container_name_upper" sed -i "804s/8888/${base_port}/" /home/eureka/.jupyter/jupyter_lab_config.py

    # Incrementar el puerto base para el siguiente contenedor
    base_port=$((base_port + 100))
done
