#!/usr/bin/env python3

import docker

# Puerto base
base_port = 1088

# Leer la lista de contenedores desde containers.txt
with open('containers.txt', 'r') as file:
    containers = file.read().splitlines()

# Inicializar el cliente Docker
client = docker.from_env()

for container_name in containers:
    # Convertir el nombre del contenedor a inicial mayúscula
    container_name_upper = container_name.capitalize()

    # Modificar el archivo dentro del contenedor
    container = client.containers.get(container_name_upper)
    exec_command = f"sed -i '804s/8888/{base_port}/' /home/eureka/.jupyter/jupyter_lab_config.py"
    container.exec_run(exec_command)

    # Incrementar el puerto base para el siguiente contenedor
    base_port += 100
