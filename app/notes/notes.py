#!/usr/bin/env python3

import os
import sys

# Define los códigos de color ANSI
RED = "\033[31m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
BLUE = "\033[34m"
ENDCOLOR = "\033[0m"

# Función para mostrar el mensaje de ayuda
def mostrar_ayuda():
    print(f"""Uso: {sys.argv[0]} [-a | -e | -l | -h]

Opciones:
  -a              Copiar todas las subcarpetas a los contenedores.
  -e              Usar el archivo "eureka.txt" para los nombres de contenedores.
  -l              Usar el archivo "logos.txt" para los nombres de contenedores.
  -h              Mostrar este mensaje de ayuda.

Ejemplos de uso:
  1. Copiar todas las subcarpetas a los contenedores usando el archivo predeterminado "containers.txt":
     {sys.argv[0]} -a

  2. Copiar una subcarpeta específica a los contenedores usando el archivo "eureka.txt":
     {sys.argv[0]} -e

  3. Copiar una subcarpeta específica a los contenedores usando el archivo "logos.txt":
     {sys.argv[0]} -l

  4. Mostrar este mensaje de ayuda:
     {sys.argv[0]} -h
""")

# Verificar si se proporciona el argumento -h
if '-h' in sys.argv:
    mostrar_ayuda()
    sys.exit()

# Mostrar una lista de directorios disponibles para copia
print(f"\n{BLUE}Directorios disponibles para copia:{ENDCOLOR}\n")
for entry in os.scandir('.'):
    if entry.is_dir():
        print(entry.name)

# Definir nombres de archivo predeterminados
container_file = "containers.txt"

# Verificar opciones de línea de comandos
if '-e' in sys.argv:
    container_file = "eureka.txt"
elif '-l' in sys.argv:
    container_file = "logos.txt"

# Leer la lista de nombres de contenedores desde el archivo
with open(container_file, "r") as file:
    container_names = [line.strip().capitalize() for line in file]

# Verificar si se proporciona el argumento -a
if '-a' in sys.argv:
    # Copiar todas las subcarpetas a los contenedores
    for subcarpeta in os.listdir('.'):
        if os.path.isdir(subcarpeta):
            for container_name in container_names:
                os.system(f'docker cp "{subcarpeta}" {container_name}:/home/eureka/')

    # Cambiar la propiedad de los archivos copiados al usuario "eureka" dentro de los contenedores
    for container_name in container_names:
        for subcarpeta in os.listdir('.'):
            if os.path.isdir(subcarpeta):
                os.system(f'docker exec -it {container_name} chown -R eureka:eureka "/home/eureka/{subcarpeta}"')

    print(f"\n{GREEN}Proceso completado{ENDCOLOR}\n")
else:
    # Solicitar al usuario el nombre de la subcarpeta a copiar
    subcarpeta = input(f"\n{YELLOW}Ingrese el nombre de la subcarpeta a copiar: {ENDCOLOR}")

    print()

    # Copiar la subcarpeta a los contenedores
    for container_name in container_names:
        os.system(f'docker cp "{subcarpeta}" {container_name}:/home/eureka/')

    # Cambiar la propiedad de los archivos copiados al usuario "eureka" dentro de los contenedores
    for container_name in container_names:
        os.system(f'docker exec -it {container_name} chown -R eureka:eureka "/home/eureka/{subcarpeta}"')

    print(f"\n{GREEN}Proceso completado{ENDCOLOR}\n")
