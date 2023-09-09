#!/bin/bash

image=eureka/jupyterlab:0.0.1-bookworm-slim

all=false
build=false
clean=false
prune=false
rebuild=false
volume=false

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
      echo "Opción no válida: $1"
      exit 1
      ;;
  esac
  shift
done

# Agregar un caso para manejar cuando no se proporcionan opciones
if [ "$all" = false ] && [ "$build" = false ] && [ "$clean" = false ] && [ "$prune" = false ] && [ "$rebuild" = false ] && [ "$volume" = false ]; then
  echo "Uso: $0 [-a] [-b] [-c] [-p] [-r] [-v]"
  echo "Opciones:"
  echo "  -a  Realizar todas las acciones (limpiar, construir, limpiar volúmenes)"
  echo "  -b  Construir los contenedores"
  echo "  -c  Limpiar contenedores y eliminar la imagen"
  echo "  -p  Limpiar recursos no utilizados de Docker"
  echo "  -r  Reconstruir los contenedores (implica limpiar y construir)"
  echo "  -v  Borrar volúmenes"
  exit 1
fi

if [ "$all" = true ]; then
  clean=true
  volume=true
  build=true
fi

if [ "$rebuild" = true ]; then
  echo "Ejecutando código para la opción -r"
  clean=true
  build=true
fi

if [ "$clean" = true ]; then
  echo "Detener y eliminar los contenedores"
  sleep 2
  docker compose down
  # Eliminar una imagen específica
  docker rmi $image
  # Limpiar recursos no utilizados de Docker
  prune=true
fi

if [ "$prune" = true ]; then
  echo "Limpiar recursos no utilizados de Docker"
  sleep 2
  yes | docker system prune
fi

if [ "$volume" = true ]; then
  echo "Borrar volúmenes"
  sleep 2
  docker volume rm \
    jupyter_newton_home \
    jupyter_newton_ssh \
    jupyter_darwin_home \
    jupyter_darwin_ssh \
    jupyter_euler_home \
    jupyter_euler_ssh \
    jupyter_arkhimedes_home \
    jupyter_arkhimedes_ssh
fi

if [ "$build" = true ]; then
  echo "Iniciar los contenedores en modo desatachado"
  sleep 2
  docker compose up -d
fi