# Juno | JupyterLab-Based STEM Learning Environment
[![License: GPL3](https://img.shields.io/badge/License-GPLv3-bd0000.svg)](https://raw.githubusercontent.com/incognia/Juno/main/LICENSE) | ![Debian](https://img.shields.io/badge/Debian-v12.1-d80150.svg) ![Docker](https://img.shields.io/badge/Docker-v24.0.5-0db7ed.svg) ![Compose](https://img.shields.io/badge/Compose-v2.20.2-0db7ed.svg) ![Python](https://img.shields.io/badge/Python-v3.11.5-306998.svg) ![JupyterLab](https://img.shields.io/badge/JupyterLab-v4.0.5-f37726.svg)

Create an immersive STEM learning environment for middle school students using JupyterLab. Our project leverages Docker Compose to orchestrate container deployments. A Python script automates the generation of the Docker Compose file, tailored to your student roster. Explore additional scripts for container maintenance, host cleanup, volume management, and seamless task distribution via Jupyter Notebooks (.ipynb).

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Building the Project](#building-the-project)
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

To get started, follow these steps:

1) Download the project from GitHub using the following command:
    ```bash
    git clone https://github.com/incognia/Juno
    ```
2) Access the project's root directory:
    ```bash
    cd Juno
    ```
3) Inside the root directory, you will encounter a file named `containers.txt` with the following contents:
    ```
    juno
    io
    europa
    ganymede
    callisto
    ```
    Please note that we've used the names of the goddess Juno (Jupiter's wife) and the four Galilean moons. It's worth mentioning that my Docker host is named "galileo," but you are free to choose your own host name.


### Stack

![Juno Docker Stack](https://raw.githubusercontent.com/incognia/Juno/main/.assets/junoStack.svg)

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
