# Juno | Entorno de aprendizaje STEM basado en JupyterLab
[![License: GPL3](https://img.shields.io/badge/License-GPLv3-bd0000.svg)](https://raw.githubusercontent.com/incognia/Juno/main/LICENSE) | ![Debian](https://img.shields.io/badge/Debian-v12.1-d80150.svg) ![Docker](https://img.shields.io/badge/Docker-v24.0.5-0db7ed.svg) ![Compose](https://img.shields.io/badge/Compose-v2.20.2-0db7ed.svg) ![Python](https://img.shields.io/badge/Python-v3.11.5-306998.svg) ![JupyterLab](https://img.shields.io/badge/JupyterLab-v4.0.5-f37726.svg)

Crear un entorno de aprendizaje STEM inmersivo para estudiantes de secundaria utilizando JupyterLab. Nuestro proyecto utiliza Docker Compose para orquestar despliegues de contenedores. Un script de Python automatiza la generación del archivo Docker Compose, adaptado a la lista de estudiantes. Explora scripts adicionales para el mantenimiento de contenedores, limpieza del host, gestión de volúmenes y distribución fluida de tareas a través de Jupyter Notebooks (.ipynb).

**Reconocimiento Especial:** Este proyecto está profundamente inspirado en el excepcional trabajo de Serena Bonaretti en "Aprende Python con Jupyter." Su proyecto sirvió como una referencia valiosa y fuente de inspiración para este proyecto, y los ejercicios incluidos en este laboratorio están directamente adaptados de su trabajo.

## Tabla de contenidos

- [Introducción](#introducción)
- [Requisitos previos](#requisitos-previos)
- [Empezando](#empezando)
- [Uso](#uso)
- [Gestión del despliegue](#gestión-del-despliegue)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)
- [Agradecimientos](#agradecimientos)

## Introducción

Únete a nosotros para empoderar a estudiantes de secundaria (edades de 12 a 15 años) con un **laboratorio de programación basado en JupyterLab**. Creemos que la experiencia práctica es fundamental para el aprendizaje, y nuestra plataforma facilita precisamente eso. A través de Docker Compose y un script de Python, hacemos que sea sencillo configurar y gestionar entornos de programación individuales para tus estudiantes, permitiéndoles sumergirse en el mundo de la codificación con facilidad.

## Requisitos previos

Antes de sumergirte en nuestro laboratorio, asegúrate de que tu sistema cumple con los siguientes requisitos:

- Un servidor equipado con Docker Engine, idealmente ejecutando Debian o Alpine Linux.
- Docker Compose para simplificar la gestión de contenedores.

Ten en cuenta que nuestro laboratorio está diseñado para funcionar en un entorno directamente accesible desde Internet. Esto se debe a que cada contenedor utiliza dos puertos: el puerto 1022 para SSH y el puerto 1088 para acceder a JupyterLab a través de un navegador web. Con cada contenedor adicional, estos números de puerto aumentan en 100 (por ejemplo, 1022, 1122, 1222 para SSH, o 1088, 1188, 1288 para Jupyter). Por lo tanto, se recomienda que tu servidor esté expuesto, es decir, que no haya reglas NAT en su lugar.

Alternativamente, el laboratorio puede funcionar dentro de una LAN que permita la personalización del DNS. Esto se puede lograr en entornos con Active Directory o configurando manualmente el archivo de hosts.

Además, es importante tener experiencia utilizando una terminal de texto y una comprensión básica de los comandos de bash, Docker y Compose, ya que estas habilidades serán esenciales para implementar y gestionar el laboratorio.

## Uso

### Para Instructores (Implementación)

Para comenzar, sigue estos pasos:

1.  Descarga el proyecto desde GitHub usando el siguiente comando:
    ```bash
    git clone https://github.com/incognia/Juno
    ```
2.  Accede al directorio raíz del proyecto:
    ```bash
    cd Juno
    ```
3.  Dentro del directorio raíz, encontrarás un archivo llamado `containers.txt` con el siguiente contenido:
    ```
    juno
    io
    europa
    ganymede
    callisto
    ```
    Ten en cuenta que hemos utilizado los nombres de la diosa Juno (esposa de Júpiter) y las cuatro lunas galileanas. Es importante mencionar que mi host de Docker se llama "galileo", pero puedes elegir tu propio nombre de host.
4.  Debes editar el archivo `containers.txt` para agregar los nombres de los estudiantes. El nombre de cada estudiante debe ser una sola palabra en minúsculas, sin espacios ni caracteres especiales como acentos o símbolos. Recomendamos usar solo letras y evitar números.

    Utiliza un editor de texto como Nano para editar el archivo:
    ```bash
    nano containers.txt
    ```
5.  Después de personalizar la lista, puedes utilizar el script `generator.py` para producir el archivo `compose.yaml`. Puedes ejecutarlo directamente con:
    ```bash
    ./generator.py
    ```
    o invocando Python 3:
    ```bash
    python3 generator.py
    ```
6.  Una vez que hayas generado el archivo `compose.yaml`, puedes iniciar los contenedores utilizando el comando estándar:
    ```bash
    docker-compose up -d
    ```
    Alternativamente, puedes utilizar el script Bash proporcionado para este propósito con la opción `-b`:
    ```bash
    ./build.sh -b
    ```
    o simplemente ejecutar:
    ```bash
    bash build.sh
    ```
7.  Si todo está configurado correctamente, deberías tener tantos contenedores creados como estudiantes en tu lista `containers.txt`. Para verificar que los contenedores se hayan creado correctamente, puedes ejecutar:
    ```bash
    docker ps
    ```
    La salida de docker ps debería parecerse a la siguiente:
    ```bash
    CONTAINER ID    STATUS                 PORTS                                                                              NAMES
    86a548f3c194    Up 28 hours            0.0.0.0:1222->22/tcp, :::1222->22/tcp, 0.0.0.0:1288->8888/tcp, :::1288->8888/tcp   Europa
    c8bce06f2686    Up 28 hours            0.0.0.0:1122->22/tcp, :::1122->22/tcp, 0.0.0.0:1188->8888/tcp, :::1188->8888/tcp   Io
    8b913b32bbe0    Up 28 hours            0.0.0.0:1022->22/tcp, :::1022->22/tcp, 0.0.0.0:1088->8888/tcp, :::1088->8888/tcp   Juno
    3d9c4c74ebba    Up 28 hours            0.0.0.0:1322->22/tcp, :::1322->22/tcp, 0.0.0.0:1388->8888/tcp, :::1388->8888/tcp   Ganymede
    5d4c60e7a597    Up 28 hours            0.0.0.0:1422->22/tcp, :::1422->22/tcp, 0.0.0.0:1488->8888/tcp, :::1488->8888/tcp   Callisto
    ```
    Asegúrate de que los nombres de los contenedores y los puertos se enumeren según lo esperado y de que cada contenedor esté "Up" y en funcionamiento.

### Para estudiantes

Si eres un estudiante, así es cómo puedes acceder y utilizar JupyterLab desde tu lado:

1.  Conéctate al servidor utilizando SSH con el siguiente comando (sustituye `<usuario>` y `<ip_servidor>` con los detalles proporcionados por tu instructor):
    ```bash
    ssh eureka@<ip_servidor> -p 1022
    ```
    Utiliza la contraseña predeterminada `3Ur3k4` cuando se te solicite.
2.  Una vez conectado, simplemente ingresa el siguiente comando para iniciar JupyterLab:
    ```bash
    jupyter-lab
    ```
3.  JupyterLab te proporcionará una URL y un token. Ten en cuenta que el puerto en la URL estará configurado en 8888 de forma predeterminada. Sin embargo, debes cambiar manualmente el puerto en la barra de direcciones de tu navegador web para que coincida con el puerto de JupyterLab asociado a tu contenedor específico. Los dos primeros dígitos del puerto de JupyterLab corresponden a los dos primeros dígitos del puerto SSH que utilizaste en el paso anterior. Por ejemplo, si usaste el puerto SSH 1022, cambia la URL a `http://<ip_servidor>:1088/lab?token=<tu_token>` si estás trabajando en el primer contenedor.
4.  Accede a JupyterLab utilizando la URL modificada con el puerto adecuado y el token proporcionado. Ten en cuenta que el token cambia con cada ejecución.

    Recuerda cerrar la sesión del servidor y detener tu sesión de JupyterLab cuando hayas terminado:
    - Para detener tu sesión de JupyterLab, vuelve a la terminal SSH y presiona `Ctrl + C`. Confirma la acción cuando se te solicite.
    - Para cerrar la sesión del servidor, simplemente escribe exit en la terminal SSH.

## Contribuciones

Anima a otros a contribuir a tu proyecto, especialmente si deseas ayuda con configuraciones de Docker Compose, extensiones de JupyterLab u otros aspectos del proyecto. Especifica cómo pueden contribuir, como bifurcar el repositorio y enviar solicitudes de extracción.

1. Bifurca el proyecto
2. Crea una rama para tu contribución: `git checkout -b feature/nueva-característica`
3. Realiza tus cambios y realiza un commit:  `git commit -m 'Add new feature'`
4. Sube tus cambios a tu repositorio: `git push origin feature/nueva-característica`
5. Abre una solicitud de extracción en GitHub

## Licencia

Este proyecto está bajo la [icencia Pública General de GNU versión 3.0 (GPL-3.0)](https://www.gnu.org/licenses/gpl-3.0.html) - consulta el archivo [LICENSE](https://raw.githubusercontent.com/incognia/Juno/main/LICENSE) para obtener más detalles.

## Agradecimientos

Me gustaría expresar mi sincero agradecimiento y reconocimiento a Serena Bonaretti por su inspirador trabajo en "Learn Python with Jupyter". Su proyecto sirvió como una valiosa referencia y fuente de inspiración para este proyecto.

- **Learn Python with Jupyter**: Visita el fantástico proyecto de Serena en [Learn Python with Jupyter](https://learnpythonwithjupyter.com/).
- **Serena Bonaretti en Twitter**: Sigue a Serena en Twitter [@serenabonaretti](https://twitter.com/serenabonaretti) para obtener más contenido perspicaz y actualizaciones.

La dedicación de Serena para hacer que Python sea accesible a través de cuadernos Jupyter ha sido una tremenda influencia en este proyecto, y estoy agradecido por sus contribuciones a la comunidad de Python.