#!/bin/bash
set -e

# Iniciar el servicio openssh-server
service ssh start

# Mantener el contenedor en ejecución
tail -f /dev/null
