#!/bin/bash

# Crear archivos de configuración para el contenedor

echo -e "version: '3.8'\nservices:" > compose.yaml
echo -e "FROM\n\nRUN\n\nCOPY app/* /app/\n\nENTRYPOINT [ "/entrypoint.sh" ]" > Dockerfile

# Crear el script de inicio

echo -e "#!/bin/bash" > entrypoint.sh
chmod +x entrypoint.sh

# Crear directorio app

mkdir app