# Juno | JupyterLab-Based STEM Learning Environment
[![License: GPL3](https://img.shields.io/badge/License-GPLv3-bd0000.svg)](https://raw.githubusercontent.com/incognia/Juno/main/LICENSE) | ![Debian](https://img.shields.io/badge/Debian-v12.1-d80150.svg) ![Docker](https://img.shields.io/badge/Docker-v24.0.6-0db7ed.svg) ![Compose](https://img.shields.io/badge/Compose-v2.21.0-0db7ed.svg) ![Python](https://img.shields.io/badge/Python-v3.11.5-306998.svg) ![JupyterLab](https://img.shields.io/badge/JupyterLab-v4.0.6-f37726.svg)

Create an immersive STEM learning environment for middle school students using JupyterLab. Our project leverages Docker Compose to orchestrate container deployments. A Python script automates the generation of the Docker Compose file, tailored to your student roster. Explore additional scripts for container maintenance, host cleanup, volume management, and seamless task distribution via Jupyter Notebooks (.ipynb).

**Special Recognition:** This project is deeply inspired by Serena Bonaretti's outstanding work on "[Learn Python with Jupyter](https://learnpythonwithjupyter.com/)." Her project served as a valuable reference and source of inspiration for this project, and the exercises included in this laboratory are directly adapted from her work.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Lesson Handling](#lesson-handling)
- [Deployment Management](#deployment-management)
- [Acknowledgments](#acknowledgments)

## Introduction

Join us in empowering middle school students (ages 12 to 15) with a **JupyterLab-based programming laboratory**. We believe that hands-on experience is key to learning, and our platform facilitates just that. Through Docker Compose and a Python script, we make it effortless to set up and manage individual programming environments for your students, allowing them to dive into the world of coding with ease.

## Prerequisites

Before diving into our lab, make sure your system meets the following requirements:

- A server equipped with Docker Engine, ideally running Debian or Alpine Linux.
- Docker Compose to streamline container management.

Please note that our lab is designed to function in an environment directly accessible from the internet. This is because each container uses two ports: port 1022 for SSH and port 1088 for accessing JupyterLab via a web browser. With each additional container, these port numbers increase by 100 (e.g., 1022, 1122, 1222 for SSH, or 1088, 1188, 1288 for Jupyter). Therefore, it's recommended that your server is exposed, meaning there are no NAT rules in place.

Alternatively, the lab can operate within a LAN that allows for DNS customization. This can be achieved in environments with Active Directory or by manually configuring the hosts file.

Additionally, it's important to have some experience using a text terminal and a basic understanding of bash, Docker, and Compose commands, as these skills will be essential for deploying and managing the lab.

## Usage

### For Instructors (Deployment)

To get started, follow these steps:

1.  Download the project from GitHub using the following command:
    ```bash
    git clone https://github.com/incognia/Juno
    ```
2.  Access the project's root directory:
    ```bash
    cd Juno
    ```
3.  Inside the root directory, you will encounter a file named `containers.txt` with the following contents:
    ```
    juno
    io
    europa
    ganymede
    callisto
    ```
    Please note that we've used the names of the goddess Juno (Jupiter's wife) and the four Galilean moons. It's worth mentioning that my Docker host is named "galileo," but you are free to choose your own host name.
4.  You need to edit the containers.txt file to add the names of the students. Each student's name should be a single word in lowercase, without spaces or special characters like accents or symbols. We recommend using only letters and avoiding numbers.

    Use a text editor like Nano to edit the file:
    ```bash
    nano containers.txt
    ```
5.  After personalizing the list, you can employ the `generator.py` script to produce the `compose.yaml` file. You can execute it directly with:
    ```bash
    ./generator.py
    ```
    or by invoking Python 3:
    ```bash
    python3 generator.py
    ```
6.  Once you've generated the compose.yaml file, you can initiate the containers using the standard command:
    ```bash
    docker-compose up -d
    ```
    Alternatively, you can employ the provided Bash script for this purpose with the `-b` option:
    ```bash
    ./build.sh -b
    ```
    or simply run:
    ```bash
    bash build.sh
    ```
7.  If everything is configured correctly, you should have as many containers created as there are students in your `containers.txt` list. To verify that the containers have been successfully created, you can run:
    ```bash
    docker ps
    ```
    The output of docker ps should resemble the following:
    ```bash
    CONTAINER ID    STATUS                 PORTS                                                                              NAMES
    86a548f3c194    Up 28 hours            0.0.0.0:1222->22/tcp, :::1222->22/tcp, 0.0.0.0:1288->8888/tcp, :::1288->8888/tcp   Europa
    c8bce06f2686    Up 28 hours            0.0.0.0:1122->22/tcp, :::1122->22/tcp, 0.0.0.0:1188->8888/tcp, :::1188->8888/tcp   Io
    8b913b32bbe0    Up 28 hours            0.0.0.0:1022->22/tcp, :::1022->22/tcp, 0.0.0.0:1088->8888/tcp, :::1088->8888/tcp   Juno
    3d9c4c74ebba    Up 28 hours            0.0.0.0:1322->22/tcp, :::1322->22/tcp, 0.0.0.0:1388->8888/tcp, :::1388->8888/tcp   Ganymede
    5d4c60e7a597    Up 28 hours            0.0.0.0:1422->22/tcp, :::1422->22/tcp, 0.0.0.0:1488->8888/tcp, :::1488->8888/tcp   Callisto
    ```
    Ensure that the container names and ports are listed as expected, and that each container is "Up" and running.

### For Students

If you're a student, here's how to access and use JupyterLab from your side:

1.  Connect to the server using SSH with the following command (replace `<username>` and `<server_ip>` with your instructor's provided details):
    ```bash
    ssh eureka@<server_ip> -p 1022
    ```
    Use the default password `3Ur3k4` when prompted.
2.  Once connected, simply enter the following command to start JupyterLab:
    ```bash
    jupyter-lab
    ```
3.  JupyterLab will provide you with a URL and a token. Please note that the port in the URL will be set to 8888 by default. However, you should manually change the port in your web browser's address bar to match the JupyterLab port associated with your specific container. The first two digits of the JupyterLab port correspond to the first two digits of the SSH port you used in the previous step. For example, if you used SSH port 1022, change the URL to `http://<server_ip>:1088/lab?token=<your_token>` if you're working in the first container.
4.  Access JupyterLab using the modified URL with the appropriate port and the token provided. Please note that the token changes with each execution.

    Remember to log out of the server and stop your JupyterLab session when you're done:
    - To stop your JupyterLab session, go back to the SSH terminal and press `Ctrl + C`. Confirm the action when prompted.
    - To log out of the server, simply type `exit` in the SSH terminal.

## Lesson Handling

One of the problems I've encountered when teaching programming is that, although the available books are relatively recent, the field of computer science advances so quickly that, within a few months, the information in the book or the examples become outdated or reference libraries or software components that have been deprecated.

That's why Serena's project was a perfect fit for our STEM classroom. Bonaretti is gradually writing her book, and every 4 to 6 weeks, she releases a new lesson. The book is divided into 10 parts, each with a varying number of lessons. For each lesson, there is an associated Jupyter Notebook (.ipynb) file with code exercises. Currently, Serena has published lesson 21, which is the first one in part 6. The next lesson (Chapter 22) is scheduled for release on October 14, 2023, although it may vary because, as a voluntary endeavor, Serena doesn't always have time to publish on the planned date.

This information is current as of today, September 14, 2023. I believe the best strategy to use an up-to-date textbook is to employ one that is still being written and revised.

### The Notes

I manually obtained Serena's Jupyter Notebooks from her [project's official website](https://learnpythonwithjupyter.com/). While it's possible to automate the download process in the future using tools like `curl` or `wget`, I chose not to invest time in automation due to the relatively small number of files (currently 21). These files were downloaded and organized within the app/notes/ directory of this repository, structured as follows:

```bash
notes/
├── 01_basics/
│   ├── 01_string_input_print.ipynb
│   └── 02_variables.ipynb
├── 02_if_else/
│   ├── 03_list_if_in_else.ipynb
│   ├── 04_list_append_remove.ipynb
│   ├── 05_list_index_pop_insert.ipynb
│   ├── 06_list_slicing.ipynb
│   └── 07_list_slicing_use.ipynb
├── 03_for_loop/
│   ├── 08_for_range.ipynb
│   ├── 09_for_loop_if_equals.ipynb
│   ├── 10_for_search.ipynb
│   ├── 11_for_change_list.ipynb
│   └── 12_for_create_list.ipynb
├── 04_numbers/
│   ├── 13_numbers.ipynb
│   ├── 14_list_of_numbers.ipynb
│   ├── 15_random.ipynb
│   └── 16_intro_to_algos.ipynb
├── 05_while/
│   ├── 17_while_loop.ipynb
│   ├── 18_while_conditions.ipynb
│   ├── 19_combining_conditions.ipynb
│   └── 20_booleans.ipynb
├── 06_recap/
│   └── 21_list_recap.ipynb
├── containers.txt -> ../../containers.txt
└── notes.py*
```
Notice that in the same directory, there is a symbolic link that points to the `containers.txt` file at the root of the project. I use that same file to iterate the actions of the `notes.py` script.

I dedicated some time to the notes.py script. Given the varying number of containers, we needed an easy way to copy the notes to all of them. This can be achieved by specifying a subfolder or by using the `-a` parameter to copy all of them in one go. This Python script is designed to facilitate the copying of directories (subfolders) to Docker containers. It offers two main use cases:

1.  Bulk Copying (With `-a` Argument): When executed with the `-a` argument, the script copies all subfolders from the current directory to multiple Docker containers defined in "containers.txt." It ensures that the copied files and subfolders are owned by the "eureka" user within each container:
    ```bash
    ./notes.py -a
    ```
    The output will be similar to this:
    ```bash
    Directorios disponibles para copia:

    01_basics
    02_if_else
    03_for_loop
    04_numbers
    05_while
    06_recap
    Successfully copied 26.1kB to Juno:/home/eureka/
    Successfully copied 26.1kB to Io:/home/eureka/
    Successfully copied 26.1kB to Europa:/home/eureka/
    Successfully copied 26.1kB to Ganymede:/home/eureka/
    Successfully copied 26.1kB to Callisto:/home/eureka/
    [...]
    Successfully copied 8.7kB to Juno:/home/eureka/
    Successfully copied 8.7kB to Io:/home/eureka/
    Successfully copied 8.7kB to Europa:/home/eureka/
    Successfully copied 8.7kB to Ganymede:/home/eureka/
    Successfully copied 8.7kB to Callisto:/home/eureka/

    Proceso completado
    ```
    This will copy all available files in the notes directory to all active containers.
2.  Single Subfolder Copying (Without `-a` Argument): Without the `-a` argument, the script prompts the user to specify the name of a particular subfolder to copy. It then copies that subfolder to all Docker containers listed in `containers.txt`, maintaining proper ownership. To do this, you can execute:
    ```bash
    ./notes.py
    ```
    The corresponding output will look something like this:
    ```bash
    Directorios disponibles para copia:

    01_basics
    02_if_else
    03_for_loop
    04_numbers
    05_while
    06_recap


    Ingrese el nombre de la subcarpeta a copiar:
    ```
    You respond to the prompt by entering one of the listed available folders, for example, `01_basics`, and press Enter. The terminal will return:
    ```bash
    Successfully copied 8.7kB to Juno:/home/eureka/
    Successfully copied 8.7kB to Io:/home/eureka/
    Successfully copied 8.7kB to Europa:/home/eureka/
    Successfully copied 8.7kB to Ganymede:/home/eureka/
    Successfully copied 8.7kB to Callisto:/home/eureka/

    Proceso completado
    ```
    This will copy the selected subfolder in the notes directory to all active containers.

## Deployment Management

Administering multiple containers can become complex once the workshop is underway. As part of a DevOps approach, it's crucial to ensure a consistent and automated deployment process for your class. When you start the first container, it triggers the image build using a Dockerfile, and subsequent containers inherit from it.

Adding new students is a breeze—all you need to do is append their names to the `containers.txt` file, rerun the `generator.py` script, and execute the `build.sh -b` command. This will create additional containers, automatically assigning the corresponding ports.

Below, I've included an image that showcases the initial stack, featuring Debian 12 as the Host OS and specific versions of Docker and Compose. You'll also observe the Python runtime and JupyterLab running on top of it:

![Initial Stack](https://raw.githubusercontent.com/incognia/Juno/main/.assets/junoStack.svg)

This approach aligns with DevOps principles, ensuring a consistent and reproducible environment for every student's programming tasks.

### Building the Image

#### Customizing Package Installation

To ensure that your programming environments are tailored to your specific requirements, you can customize the package installation process in the base image. To do this, follow these steps:

1.  Navigate to the root directory of the project, where you will find the Dockerfile.

2.  Open the Dockerfile using a text editor of your choice.

3.  Locate the section for installing additional packages, which looks like this:
    ```Dockerfile
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
    ```
4.  Customize the package installation according to your class's specific needs. You can add more packages, remove some of the ones mentioned, or make any other adjustments as required.

#### Customizing Language Package

As a default configuration, the image comes with JupyterLab and the Spanish (ES) language package preinstalled. This decision stems from the class's geographical location in Mexico City, where some students may not be fluent in English. Consequently, the code also includes comments in Spanish to facilitate comprehension. However, you have the flexibility to opt for an alternative language package that aligns with your class's needs. Here's a guide on how to replace the Spanish language package with another, such as Italian (IT):

1.  In the same Dockerfile, locate the section for installing language packages, which appears like this:
    ```Dockerfile
    # Instalamos JupyterLab y el paquete de idioma en español (ES)
    RUN  pip install jupyterlab  jupyterlab-language-pack-es-ES
    ```
    and replace the code with this:
    ```Dockerfile
    # Installiamo JupyterLab e il pacchetto di lingua in italiano (IT)
    RUN  pip install jupyterlab  jupyterlab-language-pack-it-IT
    ```
 2. Ensure that the language package you want to install is available in the Python repository and use the correct package format when installing it (e.g., jupyterlab-language-pack-it-IT for Italian).

 With these steps, you can seamlessly personalize the image construction process to meet the specific needs and language preferences of your class. Remember to save your Dockerfile changes before proceeding with image building.

#### Volumes for Persistence

Each generated container is equipped with two volumes: `{container_name}_ssh` and `{container_name}_home`. These volumes serve specific purposes in preserving the integrity of the student environments.

- `{container_name}_ssh`: In this volume, the `/etc/ssh` directory is mounted. This directory contains essential SSH configuration files. By preserving this volume, we ensure that the SSH fingerprint generated during container creation is retained. Consequently, students won't encounter authentication errors (known_hosts) when logging in again. This becomes especially valuable when you need to recreate the entire deployment for updates or maintenance.
- `{container_name}_home`: This volume is mounted to the `/home/eureka` directory, representing the default working directory for the "eureka" user. Within this directory, several preconfigured Jupyter parameters are stored. Keeping this volume allows students to maintain their individual Jupyter configurations and libraries. When you rebuild containers, whether for upgrading the OS, Python, or Jupyter versions, students won't lose their work or customizations.

These volumes provide an essential layer of persistence, ensuring that students' progress and configurations remain intact, even when making substantial changes to the deployment. The diagram below illustrates the structure of a typical (N) container and the configuration of external volumes directly mounted into the container's filesystem:

![Juno Volumes](https://raw.githubusercontent.com/incognia/Juno/main/.assets/junoVolumes.svg)

This approach enhances the flexibility and reliability of the learning environment, making it easier to manage and update while minimizing disruptions for the students.

If necessary, volumes can be deleted using the `build.sh` script with the options `-a`, `-d` or `-v`. This script offers several options for management. When executed without additional parameters, it displays a message with usage examples:
```bash
./build.sh
```
script output:
```bash
Uso: ./build.sh [-a] [-b] [-c] [-d] [-p] [-r] [-v]
Opciones:
  -a  Realizar todas las acciones (limpiar, construir, borrar volúmenes)
  -b  Construir los contenedores
  -c  Limpiar contenedores y eliminar la imagen
  -d  Limpiar contenedores, eliminar la imagen y borrar volúmenes
  -p  Limpiar recursos no utilizados de Docker
  -r  Reconstruir los contenedores (implica limpiar y construir)
  -v  Borrar volúmenes
```

#### Project structure

We've included a tree diagram depicting the general project structure, which shows the location of the scripts for management. If you modify the project, you can generate this list again by executing `tree -F .`, and then add the output to this README:

```bash
Juno/
├── app/
│   ├── etc/
│   │   └── sshd_config
│   ├── home/
│   └── notes/
│       ├── 01_basics/
│       │   ├── 01_string_input_print.ipynb
│       │   └── 02_variables.ipynb
│       ├── [...]
│       │   └── [...]
│       ├── 06_recap/
│       │   └── 21_list_recap.ipynb
│       ├── containers.txt -> ../../containers.txt
│       ├── delnotes.sh*
│       ├── eureka.txt
│       ├── folders.txt
│       ├── logos.txt
│       └── notes.py*
├── build.sh*
├── CODE_OF_CONDUCT.md
├── compose.yaml
├── containers.txt
├── CONTRIBUTING.md
├── Dockerfile
├── domain.sh*
├── entrypoint.sh*
├── generator.py*
├── LICENSE
├── ports.sh*
└── README.md
```

## Acknowledgments

I would like to extend my sincere thanks and credit to [Serena Bonaretti](https://github.com/sbonaretti) for her inspiring work on "Learn Python with Jupyter." Her project served as a valuable reference and source of inspiration for this project.

- **Learn Python with Jupyter**: Check out Serena's fantastic project at [Learn Python with Jupyter](https://learnpythonwithjupyter.com/).
- **Serena Bonaretti on Twitter**: Follow Serena on Twitter [@serenabonaretti](https://twitter.com/serenabonaretti) for more insightful content and updates.

Serena's dedication to making Python accessible through Jupyter notebooks has been a tremendous influence on this project, and I'm grateful for her contributions to the Python community.

I would also like to express my heartfelt gratitude to three of my outstanding students, [Carlos](https://github.com/cgzdev), [Ian](https://github.com/calmestprism226), and [Fernando](https://github.com/fer1495). Their remarkable talent, curiosity, and intelligence were instrumental in the development of the solution documented in this text. Teaching them for over 6 years has not only made me a better instructor but also a better human being. Their support and feedback have been invaluable throughout this journey.

Special thanks go to my dear friend and apprentice, [Amelia Chavelas](https://github.com/ameliadharani). Her unwavering support, patience, enthusiasm, and encouragement mean the world to me, not only in this project but in everything I do.
