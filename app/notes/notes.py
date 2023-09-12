#!/usr/bin/env python3

import os

# Define los códigos de color ANSI
RED = "\033[31m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
BLUE="\033[34m"
ENDCOLOR = "\033[0m"

# Mostrar una lista de directorios disponibles para copia
print(f"\n{BLUE}Directorios disponibles para copia:{ENDCOLOR}\n")
for entry in os.scandir('.'):
    if entry.is_dir():
        print(entry.name)

# Solicitar al usuario el nombre de la subcarpeta a copiar
subcarpeta = input(f"\n{YELLOW}Ingrese el nombre de la subcarpeta a copiar: {ENDCOLOR}")

print()

# Leer la lista de nombres de contenedores desde el archivo "containers.txt"
with open("containers.txt", "r") as file:
    container_names = [line.strip().capitalize() for line in file]

# Copiar la subcarpeta a los contenedores
for container_name in container_names:
    os.system(f'docker cp "{subcarpeta}" {container_name}:/home/eureka/')

# Cambiar la propiedad de los archivos copiados al usuario "eureka" dentro de los contenedores
for container_name in container_names:
    os.system(f'docker exec -it {container_name} chown -R eureka:eureka "/home/eureka/{subcarpeta}"')

print(f"\n{GREEN}Proceso completado{ENDCOLOR}\n")
