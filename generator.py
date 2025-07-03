#!/usr/bin/env python3

# Abre el archivo "containers.txt" en modo lectura y lo almacena en 'file'.
with open("containers.txt", "r") as file:
    # Lee el contenido del archivo y divide las líneas en una lista.
    container_names = file.read().splitlines()

# Plantilla para el archivo de composición Docker.
compose_template = """
services:
{}
volumes:
"""

# Plantilla para la configuración de un servicio en el archivo de composición Docker.
service_template = """
  {}:
    image: eureka/jupyterlab:0.0.2-bookworm-slim
    container_name: {}
    hostname: {}
    ports:
      - {}:22
      - {}:8888
    tty: true
    stdin_open: true
    restart: always
    volumes:
      - {}_home:/home/eureka
      - {}_ssh:/etc/ssh{}
"""

# Cadena vacía para almacenar las definiciones de servicios y volúmenes.
services = ""
volumes = ""

# Itera sobre la lista de nombres de contenedores y genera las definiciones de servicios y volúmenes.
for index, name in enumerate(container_names):
    build_params = ""
    ssh_port = 1022 + (index * 100)
    jupyter_port = 1088 + (index * 100)
    
    # Si es el primer contenedor, agrega parámetros de construcción.
    if index == 0:
        build_params = """
    build:
      context: .
      dockerfile: Dockerfile
"""
    
    # Agrega la definición de servicio al conjunto de servicios.
    services += service_template.format(name, name.capitalize(), name, ssh_port, jupyter_port, name, name, build_params)
    
    # Agrega la definición de volúmenes al conjunto de volúmenes usando el nombre del contenedor.
    volumes += "  {}_home:\n".format(name)
    volumes += "  {}_ssh:\n".format(name)

# Crea el archivo de composición Docker utilizando la plantilla y las definiciones de servicios y volúmenes.
docker_compose_file = compose_template.format(services) + volumes

# Abre el archivo "compose.yaml" en modo escritura y escribe el contenido generado.
with open("compose.yaml", "w") as compose_file:
    compose_file.write(docker_compose_file)

