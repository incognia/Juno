# Juno | JupyterLab-Based STEM Learning Environment
[![License: GPL3](https://img.shields.io/badge/License-GPLv3-bd0000.svg)](https://raw.githubusercontent.com/incognia/Juno/main/LICENSE) | ![Debian](https://img.shields.io/badge/Debian-v12.1-d80150.svg) ![Docker](https://img.shields.io/badge/Docker-v24.0.5-0db7ed.svg) ![Compose](https://img.shields.io/badge/Compose-v2.20.2-0db7ed.svg) ![Python](https://img.shields.io/badge/Python-v3.11.5-306998.svg) ![JupyterLab](https://img.shields.io/badge/JupyterLab-v4.0.5-f37726.svg)

Create an immersive STEM learning environment for middle school students using JupyterLab. Our project leverages Docker Compose to orchestrate container deployments. A Python script automates the generation of the Docker Compose file, tailored to your student roster. Explore additional scripts for container maintenance, host cleanup, volume management, and seamless task distribution via Jupyter Notebooks (.ipynb).

**Special Recognition:** This project is deeply inspired by Serena Bonaretti's outstanding work on "Learn Python with Jupyter." Her project served as a valuable reference and source of inspiration for this project, and the exercises included in this laboratory are directly adapted from her work.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Managing the Deployment](#managing-the-deployment)
- [Contributing](#contributing)
- [License](#license)
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
4. You need to edit the containers.txt file to add the names of the students. Each student's name should be a single word in lowercase, without spaces or special characters like accents or symbols. We recommend using only letters and avoiding numbers.

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
    Or simply run:
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

## Managing the Deployment

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

By default, the image includes JupyterLab and the Spanish (ES) language package. However, you may prefer to use a different language package based on your class's preferences. Here's how you can replace the Spanish language package with another, such as Italian (IT):

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

### Volumes

![Juno Volumes](https://raw.githubusercontent.com/incognia/Juno/main/.assets/junoVolumes.svg)


## Project structure

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
│       ├── 02_if_else/
│       │   ├── 03_list_if_in_else.ipynb
│       │   ├── 04_list_append_remove.ipynb
│       │   ├── 05_list_index_pop_insert.ipynb
│       │   ├── 06_list_slicing.ipynb
│       │   └── 07_list_slicing_use.ipynb
│       ├── 03_for_loop/
│       │   ├── 08_for_range.ipynb
│       │   ├── 09_for_loop_if_equals.ipynb
│       │   ├── 10_for_search.ipynb
│       │   ├── 11_for_change_list.ipynb
│       │   └── 12_for_create_list.ipynb
│       ├── 04_numbers/
│       │   ├── 13_numbers.ipynb
│       │   ├── 14_list_of_numbers.ipynb
│       │   ├── 15_random.ipynb
│       │   └── 16_intro_to_algos.ipynb
│       ├── 05_while/
│       │   ├── 17_while_loop.ipynb
│       │   ├── 18_while_conditions.ipynb
│       │   ├── 19_combining_conditions.ipynb
│       │   └── 20_booleans.ipynb
│       ├── 06_recap/
│       │   └── 21_list_recap.ipynb
│       ├── containers.txt -> ../../containers.txt
│       └── notes.py*
├── build.py*
├── build.sh*
├── compose.yaml
├── containers.txt
├── Dockerfile
├── entrypoint.sh*
├── generator.py*
├── LICENSE
└── README.md
```

## Contributing

Encourage others to contribute to your project, especially if you'd like help with Docker Compose configurations, JupyterLab extensions, or other aspects of the project. Specify how they can contribute, such as forking the repository and submitting pull requests.

1. Fork the project
2. Create a branch for your contribution: `git checkout -b feature/new-feature`
3. Make your changes and commit: `git commit -m 'Add new feature'`
4. Push your changes to your repository: `git push origin feature/new-feature`
5. Open a pull request on GitHub


## License

This project is licensed under the [GNU General Public License v3.0 (GPL-3.0)](https://www.gnu.org/licenses/gpl-3.0.html) - see the [LICENSE](https://raw.githubusercontent.com/incognia/Juno/main/LICENSE) file for more details.

## Acknowledgments

I would like to extend my sincere thanks and credit to Serena Bonaretti for her inspiring work on "Learn Python with Jupyter." Her project served as a valuable reference and source of inspiration for this project.

- **Learn Python with Jupyter**: Check out Serena's fantastic project at [Learn Python with Jupyter](https://learnpythonwithjupyter.com/).
- **Serena Bonaretti on Twitter**: Follow Serena on Twitter [@serenabonaretti](https://twitter.com/serenabonaretti) for more insightful content and updates.

Serena's dedication to making Python accessible through Jupyter notebooks has been a tremendous influence on this project, and I'm grateful for her contributions to the Python community.
