#!/bin/bash

# Detener y eliminar los contenedores
docker compose down

# Eliminar una imagen específica
docker rmi eureka/jupyterlab:0.0.1-bookworm-slim

# Pausar la ejecución del script durante 5 segundos
sleep 5

# Limpiar recursos no utilizados de Docker
yes | docker system prune

# Pausar la ejecución del script durante 5 segundos
sleep 5

# Iniciar los contenedores en modo desatachado
docker compose up -d

# Ejecutar un shell interactivo dentro del contenedor "JupyterLab"
# docker exec -it -u incognia JupyterLab bash