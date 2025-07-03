#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

# Define una variable 'image' que almacena la imagen de Docker que se utilizará en el script.
image=eureka/jupyterlab:0.0.2-bookworm-slim

# Variables booleanas que indicarán qué acciones se deben realizar. Inicialmente, todas están configuradas como falsas.
all=false
build=false
clean=false
delete=false
prune=false
rebuild=false
volume=false

# Inicio del bucle while que procesa las opciones de línea de comandos.
while [[ $# -gt 0 ]]; do
    case "$1" in
    -a)
        all=true
        ;;
    -b)
        build=true
        ;;
    -c)
        clean=true
        ;;
    -d)
        delete=true
        ;;
    -p)
        prune=true
        ;;
    -r)
        rebuild=true
        ;;
    -v)
        volume=true
        ;;
    *)
        echo -e "\n${YELLOW}Opción no válida: $1${ENDCOLOR}\n"
        exit 1
        ;;
    esac
    shift
done
# Fin del bucle while que analiza las opciones de línea de comandos y establece las variables booleanas según corresponda.

# Si ninguna de las variables booleanas está configurada como verdadera, muestra un mensaje de uso y sale con un código de error.
if [ "$all" = false ] && [ "$build" = false ] && [ "$clean" = false ] && [ "$delete" = false ] && [ "$prune" = false ] && [ "$rebuild" = false ] && [ "$volume" = false ]; then
    echo "Uso: $0 [-a] [-b] [-c] [-d] [-p] [-r] [-v]"
    echo "Opciones:"
    echo "  -a  Realizar todas las acciones (limpiar, construir, borrar volúmenes)"
    echo "  -b  Construir los contenedores"
    echo "  -c  Limpiar contenedores y eliminar la imagen"
    echo "  -d  Limpiar contenedores, eliminar la imagen y borrar volúmenes"
    echo "  -p  Limpiar recursos no utilizados de Docker"
    echo "  -r  Reconstruir los contenedores (implica limpiar y construir)"
    echo "  -v  Borrar volúmenes"
    exit 1
fi

# Si la opción -a está configurada como verdadera, establece todas las demás opciones como verdaderas también.
if [ "$all" = true ]; then
    clean=true
    volume=true
    prune=true
    build=true
fi

# Si la opción -r está configurada como verdadera, ejecuta un mensaje específico.
if [ "$rebuild" = true ]; then
    echo -e "\n${GREEN}Reconstruir contenedores${ENDCOLOR}\n"
    clean=true
    prune=true
    build=true
fi

# Si la opción -c, -d  o -r está configurada como verdadera, ejecuta acciones para limpiar contenedores, imágenes y volúmenes de Docker.
if [ "$delete" = true ]; then
    clean=true
    volume=true
    prune=true
fi

# Si la opción -c, -d o -r está configurada como verdadera, ejecuta acciones para limpiar contenedores e imágenes de Docker.
if [ "$clean" = true ]; then
    echo -e "\n${RED}Detener y eliminar los contenedores${ENDCOLOR}\n"
    sleep 2
    docker compose down
    echo -e "\n${RED}Eliminar la imagen: ${YELLOW}$image${ENDCOLOR}\n"
    sleep 2
    docker rmi $image
fi

# Si la opción -v está configurada como verdadera, elimina volúmenes específicos de Docker.
if [ "$volume" = true ]; then
    echo -e "\n${RED}Borrar volúmenes${ENDCOLOR}\n"
    sleep 2
    docker compose down -v 
fi

# Si la opción -p está configurada como verdadera, limpia recursos no utilizados de Docker.
if [ "$prune" = true ]; then
    echo -e "\n${YELLOW}Limpiar recursos no utilizados de Docker${ENDCOLOR}\n"
    sleep 2
    yes | docker system prune
fi

# Si la opción -b o -a está configurada como verdadera, inicia los contenedores en modo desacoplado.
if [ "$build" = true ]; then
    echo -e "\n${GREEN}Iniciar los contenedores en modo desacoplado${ENDCOLOR}\n"
    sleep 2
    docker compose up -d
fi
