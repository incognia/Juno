# Juno | JupyterLab-Based STEM Learning Environment
[![License: GPL3](https://img.shields.io/badge/License-GPLv3-bd0000.svg)](https://raw.githubusercontent.com/incognia/Juno/main/LICENSE) | ![Debian](https://img.shields.io/badge/Debian-v12.1-d80150.svg) ![Docker](https://img.shields.io/badge/Docker-v24.0.5-0db7ed.svg) ![Compose](https://img.shields.io/badge/Compose-v2.20.2-0db7ed.svg) ![Python](https://img.shields.io/badge/Python-v3.11.5-306998.svg) ![JupyterLab](https://img.shields.io/badge/JupyterLab-v4.0.5-f37726.svg)

Create an immersive STEM learning environment for middle school students (ages 12 to 15) using JupyterLab. Our project leverages Docker Compose to orchestrate container deployments. A Python script automates the generation of the Docker Compose file, tailored to your student roster. Explore additional scripts for container maintenance, host cleanup, volume management, and seamless task distribution via Jupyter Notebooks (.ipynb).

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

**Empower Middle School Students with Our JupyterLab Programming Lab** Join us in empowering middle school students (ages 12 to 15) with a JupyterLab-based programming laboratory. We believe that hands-on experience is key to learning, and our platform facilitates just that. Through Docker Compose and a Python script, we make it effortless to set up and manage individual programming environments for your students, allowing them to dive into the world of coding with ease.

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
## License

This project is licensed under the [GNU General Public License v3.0 (GPL-3.0)](https://www.gnu.org/licenses/gpl-3.0.html) - see the [LICENSE](https://raw.githubusercontent.com/incognia/Juno/main/LICENSE) file for more details.

## Acknowledgments

I would like to extend my sincere thanks and credit to Serena Bonaretti for her inspiring work on "Learn Python with Jupyter." Her project served as a valuable reference and source of inspiration for this project.

- **Learn Python with Jupyter**: Check out Serena's fantastic project at [Learn Python with Jupyter](https://learnpythonwithjupyter.com/).
- **Serena Bonaretti on Twitter**: Follow Serena on Twitter [@serenabonaretti](https://twitter.com/serenabonaretti) for more insightful content and updates.

Serena's dedication to making Python accessible through Jupyter notebooks has been a tremendous influence on this project, and I'm grateful for her contributions to the Python community.
