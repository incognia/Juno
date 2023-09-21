#   Dasboard - Display System Information with Streamlit
#
#   Copyright © 2023, Rodrigo Ernesto Álvarez Aguilera <incognia@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Version 0.1 - September 21, 2023
#   Author: Rodrigo Ernesto Álvarez Aguilera
#
#   Tested under Debian "bookworm" using Python 3.11.2 and Streamlit 1.26.0
#

import streamlit as st
import matplotlib.pyplot as plt
import os
import platform
import psutil

# --------[ Información del sistema ]-------------------------------------------

# Función para obtener información del sistema
def obtener_informacion_sistema():
    host = platform.node()
    sistema = platform.system()
    arquitectura = platform.architecture()
    kernel = platform.release()
    release = os.popen("lsb_release -d | cut -f 2").read().strip()
    total_nucleos = psutil.cpu_count(logical=True)  # Contar núcleos lógicos
    totlal_memoria = psutil.virtual_memory().total / (1024 ** 3)  # Convertir a GB
    uptime = os.popen("uptime -p").read().strip()

    informacion = f"Host: {host}\n"
    informacion += f"Sistema operativo: {sistema}\n"
    informacion += f"Versión: {release}\n"
    informacion += f"Arquitectura: {arquitectura[0]}\n"
    informacion += f"Kernel: {kernel}\n"
    informacion += f"Total de núcleos: {total_nucleos}\n"
    informacion += f"Total de memoria: {totlal_memoria:.2f} GB\n"
    informacion += f"Tiempo de actividad: {uptime}\n"

    return informacion

# Título y encabezado
st.title("Información del sistema")

# Obtener y mostrar la información del sistema
informacion_sistema = obtener_informacion_sistema()
st.code(informacion_sistema, language="text")

# --------[ Uso de CPU ]--------------------------------------------------------

# Obtener el uso actual de la CPU
uso_cpu = psutil.cpu_percent(interval=1, percpu=True)

# Crear una gráfica de barras horizontales con el uso de CPU
st.title("Uso de CPU")
st.write("Uso de CPU por núcleo:")

# Crear una gráfica de barras horizontales para cada núcleo
fig, ax = plt.subplots()
nucleos = [f"Núcleo {i + 1:02d}" for i in range(len(uso_cpu))]  # Formato de dos dígitos
ax.barh(nucleos, uso_cpu)
ax.set_xlabel("Uso de CPU (%)")

# Personalizar las etiquetas del eje Y
ax.invert_yaxis()  # Invertir el eje Y para que el núcleo 1 esté en la parte superior

# Mostrar la gráfica en Streamlit
st.pyplot(fig)

# --------[ Uso de memoria ]----------------------------------------------------

# Obtener el uso actual de la memoria
memoria = psutil.virtual_memory()

# Convertir bytes a GB
memoria_total_gb = memoria.total / (1024 ** 3)
memoria_usada_gb = memoria.used / (1024 ** 3)
memoria_disponible_gb = memoria.available / (1024 ** 3)

# Crear una gráfica de memoria en GB
st.title("Uso de memoria")
st.write(f"Memoria total: {memoria_total_gb:.2f} GB")
st.write(f"Memoria usada: {memoria_usada_gb:.2f} GB")
st.write(f"Memoria disponible: {memoria_disponible_gb:.2f} GB")

etiquetas = ["Memoria usada", "Memoria disponible", "Memoria total"]
valores_gb = [memoria_usada_gb, memoria_disponible_gb, memoria_total_gb]

# Crear un gráfico de barras
fig, ax = plt.subplots()
ax.bar(etiquetas, valores_gb, color=['blue', 'green', 'red'])
ax.set_ylabel("Memoria (GB)")
ax.set_title("Uso de memoria")

# Mostrar la gráfica en Streamlit
st.pyplot(fig)

# ------------------------------------------------------------------------------
