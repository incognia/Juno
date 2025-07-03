#!/bin/bash
set -e

# Iniciar el servicio openssh-server
service ssh start

# Auto-iniciar JupyterLab como usuario eureka
su - eureka -c "python3 -m jupyterlab --ip=0.0.0.0 --port=8888 --no-browser --allow-root > /tmp/jupyter.log 2>&1 &"

# Esperar a que JupyterLab se inicie completamente
sleep 5

# Mantener el contenedor en ejecución
tail -f /dev/null
