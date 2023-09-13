#!/usr/bin/env python3

import argparse
import subprocess
import time

# Define los códigos de color ANSI
RED = "\033[31m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
ENDCOLOR = "\033[0m"

# Define la imagen de Docker
image = "eureka/jupyterlab:0.0.1-bookworm-slim"

# Función para limpiar contenedores
def clean_containers():
    print(f"\n{RED}Detener y eliminar los contenedores{ENDCOLOR}\n")
    time.sleep(2)
    subprocess.run(["docker", "compose", "down"])

# Función para eliminar la imagen
def delete_image():
    print(f"\n{RED}Eliminar la imagen: {YELLOW}{image}{ENDCOLOR}\n")
    time.sleep(2)
    subprocess.run(["docker", "rmi", image])

# Función para borrar volúmenes
def delete_volumes():
    print(f"\n{RED}Borrar volúmenes{ENDCOLOR}\n")
    time.sleep(2)
    subprocess.run(["docker", "volume", "prune", "-f"])

# Función para limpiar recursos no utilizados de Docker
def prune_docker_resources():
    print(f"\n{YELLOW}Limpiar recursos no utilizados de Docker{ENDCOLOR}\n")
    time.sleep(2)
    subprocess.run(["docker", "system", "prune", "-f"])

# Función para construir los contenedores
def build_containers():
    print(f"\n{GREEN}Iniciar los contenedores en modo desacoplado{ENDCOLOR}\n")
    time.sleep(2)
    subprocess.run(["docker", "compose", "up", "-d"])

def main():
    parser = argparse.ArgumentParser(description="Gestión de contenedores Docker")
    parser.add_argument("-a", action="store_true", help="Realizar todas las acciones")
    parser.add_argument("-b", action="store_true", help="Construir los contenedores")
    parser.add_argument("-c", action="store_true", help="Limpiar contenedores y eliminar la imagen")
    parser.add_argument("-d", action="store_true", help="Limpiar contenedores, eliminar la imagen y borrar volúmenes")
    parser.add_argument("-p", action="store_true", help="Limpiar recursos no utilizados de Docker")
    parser.add_argument("-r", action="store_true", help="Reconstruir los contenedores (implica limpiar y construir)")
    parser.add_argument("-v", action="store_true", help="Borrar volúmenes")
    args = parser.parse_args()

    # Si ninguna opción está especificada, muestra el mensaje de ayuda
    if not any(vars(args).values()):
        parser.print_help()
        return

    if args.a:
        args.b = args.c = args.d = args.p = args.r = args.v = True

    if args.r:
        print(f"\n{GREEN}Reconstruir contenedores{ENDCOLOR}\n")
        args.c = args.d = args.p = args.b = True

    if args.c:
        clean_containers()

    if args.d:
        clean_containers()
        delete_image()
        delete_volumes()

    if args.p:
        prune_docker_resources()

    if args.b:
        build_containers()

if __name__ == "__main__":
    main()
