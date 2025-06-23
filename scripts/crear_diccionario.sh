#!/bin/bash
# Autor: Johanna Atenea
# Descripción:
# Almacena las posiciones de los genes que pertenezcan al clúser de scytonemin en aquellos genomas en los cuales se detectó
# presencia, el resultado lo devuelve en número de genes.  Para correrlo es necesario los resultados del script 'detectar_scytonemin.sh'
# Uso: bash crear_diccionario.sh $resultados_script_'detectar_scytonemin.sh'
# Salida: diccionario.txt
entrada="$1"
output="diccionario.txt"
echo "{" > "$output"

for file in genomas_con_scytonemin/*.txt; do
    id=$(basename "$file" .txt)
    genes=$(paste -sd, "$file")
    echo "    \"$id\": [${genes}]," >> "$output"
done

# Quitar la coma final del último elemento
sed -i '$ s/,$//' "$output"

echo "}" >> "$output"
