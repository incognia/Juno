FROM python:slim-bookworm

# Actualiza la lista de paquetes disponibles
RUN apt-get update \
    # Instala el paquete "aptitude" de forma silenciosa
    && apt-get install -y aptitude \
    # Realiza una actualización segura de paquetes de forma silenciosa
    && aptitude safe-upgrade -y

# Instalar paquetes adicionales de forma silenciosa
RUN apt-get install -y \ 
    # Autocompletado de Bash 
    bash-completion \
    # Transferencia de datos
    curl \
    # Monitor de procesos
    htop \
    # Administrador de archivos
    mc \
    # Editor de texto simple
    nano \
    # Información del sistema
    neofetch \
    # Editor de texto avanzado
    neovim \
    # Entorno en tiempo de ejecución
    nodejs \
    # Servidor SSH
    openssh-server \
    # Ejecutar comandos con privilegios
    sudo \
    # Herramienta de descarga
    wget

# Desinstalar navegador web basado en texto con sus dependencias
RUN apt purge w3m -y && apt autoremove --purge -y

# Configurar zona horaria
ENV TZ=America/Mexico_City
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Establecer contraseña del usuario root
RUN echo "root:P@$$w0rd" | chpasswd

# Crear usuario eureka y establecer contraseña
RUN useradd -m -s /bin/bash eureka && echo "eureka:N3p3" | chpasswd

# Agregar usuario eureka al grupo sudo
RUN usermod -aG sudo eureka

# Copia todos los archivos de app/ al directorio /app/
COPY app/* /app/
# Copia .nanorc al directorio /home/eureka/
RUN cat /app/.nanorc > /home/eureka/.nanorc
# Crear directorio /home/eureka/.jupyter/
RUN mkdir /home/eureka/.jupyter
# Copia jupyter_lab_config.py al directorio /home/eureka/.jupyter/
RUN cat /app/jupyter_lab_config.py > /home/eureka/.jupyter/jupyter_lab_config.py
# Cambiamos al usuario "eureka"
USER eureka
# Instalamos JupyterLab y el paquete de idioma en español (ES)
RUN  pip install jupyterlab  jupyterlab-language-pack-es-ES
# Cambiamos de nuevo al usuario "root"
USER root
# Asigna el usuario eureka como propietario del directorio /home/eureka/
RUN chown -R eureka:eureka /home/eureka

# Configurar el script de inicio
COPY entrypoint.sh /entrypoint.sh
# Otorga permisos ejecución a entrypoint.sh
RUN chmod +x /entrypoint.sh

# Iniciar servicios
ENTRYPOINT [ "/entrypoint.sh" ]