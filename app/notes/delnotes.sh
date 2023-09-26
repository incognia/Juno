#!/bin/bash

# Función para capitalizar una cadena
capitalize() {
    local input="$1"
    echo "${input^}"
}

# Leer el archivo 'containers.txt' y almacenar los nombres capitalizados en una matriz
container_names=($(cat containers.txt))

# Capitalizar los nombres de los contenedores
capitalized_container_names=()
for name in "${container_names[@]}"; do
    capitalized_container_names+=("$(capitalize "$name")")
done

# Leer el archivo 'folders.txt' y almacenar las rutas en una matriz
folder_paths=($(cat folders.txt))

# Iterar sobre los contenedores
for container_name in "${capitalized_container_names[@]}"; do
    # Iterar sobre las rutas de directorio y eliminarlas dentro del contenedor
    for folder_path in "${folder_paths[@]}"; do
        docker exec "$container_name" rm -rf "$folder_path"
        echo "Eliminando $folder_path en $container_name"
    done
done

