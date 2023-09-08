#!/bin/bash

# Detener y eliminar los contenedores
docker compose down

# Eliminar una imagen específica
docker rmi eureka/jupyterlab:0.0.1-bookworm-slim

# Pausar la ejecución del script durante 3 segundos
sleep 3

# Borrar volúmenes
docker volume rm \
  jupyter_newton_home \
  jupyter_newton_ssh \
  jupyter_darwin_home \
  jupyter_darwin_ssh \
  jupyter_euler_home \
  jupyter_euler_ssh \
  jupyter_arkhimedes_home \
  jupyter_arkhimedes_ssh

# Pausar la ejecución del script durante 3 segundos
sleep 3

# Limpiar recursos no utilizados de Docker
yes | docker system prune