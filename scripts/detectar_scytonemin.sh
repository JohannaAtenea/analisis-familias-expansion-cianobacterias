#!/bin/bash
#Autor: Johanna Atenea
# Descripción:
# Este script filtra los resultados del script 'scytonemin.sh' de modo que sólo conserva aquellos genes con un evalue bajo 
# y un pident mayor a 80%.

## Us: detectar_scytonemin.sh 
# Archivo con los IDs de los genomas que contienen scytonemin
ids_con_scy="ids_scytonemin.txt"

# Carpeta donde están los archivos TSV
carpeta_blast="resultados_blast"

# Leer cada ID del archivo
while read -r id; do
    archivo="$carpeta_blast/$id.tsv"
    salida="genomas_con_scytonemin/${id}.txt"

    if [[ -f "$archivo" ]]; then
        # Filtrar las líneas que cumplen los criterios y extraer el número después de "peg."
        awk '$3 >= 80 && $5 <= 1e-10 {
            if (match($2, /peg\.([0-9]+)/, m)) {
                print m[1]
            }
        }' "$archivo" > "$salida"
        echo "✅ Genes guardados en $salida"
    else
        echo "⚠️ No se encontró el archivo $archivo"
    fi
done < "$ids_con_scy"
