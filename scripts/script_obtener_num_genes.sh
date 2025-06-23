#!/bin/bash
# Autor: Johanna Atenea
# Descripción:
# Este script cuenta cuantos genes tiene cada uno de los genomas del grupo de estudio, para ejecutarlo se hace uso 
# de los archivos .gbk contenidos en la carpeta 'Cianobacterias' almacenada en la carpeta 'Datasets' de este repositorio.
# Uso: bash script_obtener_num_genes.sh ids_genomas.txt Cianobacterias/
# Archivo con la lista de identificadores
GENOMES_LIST=$1
# Carpeta donde están los archivos .gbk
GENBANK_FOLDER=$2
# Archivo de salida .csv
OUTPUT_CSV="numero_de_genes.csv"

# Encabezado del archivo CSV
echo "genome_id,number_of_genes" > "$OUTPUT_CSV"

# Leer la lista de identificadores y contar los genes en los archivos .gbk
while IFS= read -r genome_id; do
    # Ruta del archivo GenBank para este identificador
    GENBANK_FILE="${GENBANK_FOLDER}/${genome_id}.gbk"
    
    if [[ -f "$GENBANK_FILE" ]]; then
        # Contar el número de genes (buscando 'gene' en las líneas del archivo .gbk)
        gene_count=$(grep -c "peg" "$GENBANK_FILE")
        
        # Escribir el resultado en el archivo CSV
        echo "${genome_id},${gene_count}" >> "$OUTPUT_CSV"
    else
        # Si no se encuentra el archivo .gbk, escribir 0 genes
        echo "${genome_id},0" >> "$OUTPUT_CSV"
    fi
done < "$GENOMES_LIST"

echo "El conteo de genes se ha guardado en $OUTPUT_CSV"

