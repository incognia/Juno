#!/bin/bash

# Pide al usuario que ingrese el nuevo dominio
echo "Por favor, ingresa el nuevo dominio:"
read nuevo_dominio

# Usa sed para reemplazar la cadena en el archivo
sed -i "804s/faraday\.org\.mx/$nuevo_dominio/g" app/home/.jupyter/jupyter_lab_config.py

echo "La cadena se ha reemplazado correctamente en el archivo."
