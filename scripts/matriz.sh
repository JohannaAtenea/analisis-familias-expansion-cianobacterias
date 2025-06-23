# Autor: Johanna Atenea
# Descripción: 
# Este script construye la matriz de abundancia para las familias de genes (carpeta /familias, descaragar de la carpeta 
# Datasets de este repositorio) y los 29 genomas, además es necesario contar con los resultados del scriptconteos_por_genoma.sh
# Uso: matriz.sh conteos/ 
#!/bin/bash

# Lista de genomas posibles
GENOMAS=("103690.82" "1472755.9" "1618022.9" "1647413.14" "1751286.15" "1869241.20" "1914872.23" "2038116.21" "211165.20" "2490939.10" "2572090.7" "2576902.6" "2576903.5" "2576904.6" "2653204.7" "272123.44" "2764711.14" "28072.26" "2914041.10" "3025190.14" "3134896.7" "317936.27" "3349875.4" "3349876.5" "446679.11" "449208.14" "46234.36" "63737.69" "76335.23")

# Carpeta con los archivos de conteo (suponiendo que los archivos se llaman como familia_conteo.tsv)
INPUT_DIR=$1
OUTPUT_DIR="/files/atenea/bacterias/Cianobacterias_corregidas/matriz_abundancia"

# Crear la carpeta de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Archivo de salida para la matriz de abundancia
OUTPUT_FILE="$OUTPUT_DIR/matriz_abundancia.csv"

# Imprimir los encabezados (los nombres de los genomas) en el archivo de salida
echo -n "Familia" > "$OUTPUT_FILE"
for GENOMA in "${GENOMAS[@]}"; do
    echo -n -e "\t$GENOMA" >> "$OUTPUT_FILE"
done
echo "" >> "$OUTPUT_FILE"

# Procesar cada archivo de conteo
for FILE in "$INPUT_DIR"/*_conteo.tsv; do
    # Obtener el nombre de la familia (sin la ruta y extensión)
    FAMILY_NAME=$(basename "$FILE" "_conteo.tsv")

    # Imprimir el nombre de la familia en la primera columna
    echo -n "$FAMILY_NAME" >> "$OUTPUT_FILE"

    # Leer los conteos de cada genoma en este archivo
    for GENOMA in "${GENOMAS[@]}"; do
        # Obtener el conteo de genes para este genoma
        COUNT=$(grep "^$GENOMA" "$FILE" | awk '{print $2}')

        # Si no hay conteo para este genoma, usar 0
        if [ -z "$COUNT" ]; then
            COUNT=0
        fi

        # Escribir el conteo en la matriz
        echo -n -e "\t$COUNT" >> "$OUTPUT_FILE"
    done

    # Agregar una nueva línea para separar las filas
    echo "" >> "$OUTPUT_FILE"

    echo "Procesado: $FAMILY_NAME"
done

echo "Matriz de abundancia generada en $OUTPUT_FILE"

