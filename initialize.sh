#!/bin/bash

# Crear archivos de configuración para el contenedor
echo -e "version: '3.8'\nservices:" > compose.yaml
echo -e "FROM image:tag\n\n" > Dockerfile
echo -e "RUN apt-get update && apt-get install -y\n\n" >> Dockerfile
echo -e "COPY app/* /app/\n\n" >> Dockerfile
echo -e "COPY entrypoint.sh /entrypoint.sh\n\n" >> Dockerfile
echo -e "RUN chmod +x /entrypoint.sh\n\n" >> Dockerfile
echo -e "ENTRYPOINT [ "/entrypoint.sh" ]" >> Dockerfile

# Crear directorio app
mkdir app
touch app/app.txt

# Crear el script de inicio
echo -e "#!/bin/bash" > entrypoint.sh
chmod +x entrypoint.sh