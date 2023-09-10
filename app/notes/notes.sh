#!/bin/bash

# Mostrar una lista de directorios disponibles para copia
echo "Directorios disponibles para copia:"
find . -maxdepth 1 -type d

# Solicitar al usuario el nombre de la subcarpeta a copiar
read -p "Ingrese el nombre de la subcarpeta a copiar: " subcarpeta

# Copiar la subcarpeta a los contenedores
docker cp "$subcarpeta" Newton:/home/eureka/
docker cp "$subcarpeta" Darwin:/home/eureka/
docker cp "$subcarpeta" Euler:/home/eureka/
docker cp "$subcarpeta" Arkhimedes:/home/eureka/

# Cambiar la propiedad de los archivos copiados al usuario "eureka" dentro de los contenedores
docker exec -it Newton chown -R eureka:eureka "/home/eureka/$subcarpeta"
docker exec -it Darwin chown -R eureka:eureka "/home/eureka/$subcarpeta"
docker exec -it Euler chown -R eureka:eureka "/home/eureka/$subcarpeta"
docker exec -it Arkhimedes chown -R eureka:eureka "/home/eureka/$subcarpeta"
