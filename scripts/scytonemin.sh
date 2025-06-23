#!/bin/bash
# Autor: Johanna Atenea
# Descripción:
# Este script compara los genomas del grupo de estudio contra los genes del clúster de scytonemin usando BLASTp.
# Para cada genoma en la lista, ejecuta la búsqueda BLAST con la secuencia query proporcionada.
# Regresa una carpeta con los resultados de la comparación, que se utilizan en los demás scripts del proyecto.
# Uso: scytonemin.sh $scytonemin.faa $ids_genomas.txt $carpeta_con_genomas_en_formato_faa
# Validación de argumentos
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <query.faa> <ids_genomas.txt> <carpeta_con_genomas_faa>"
    exit 1
fi
query=$1
lista_ids=$2
carpeta_faa=$3
salida="resultados_blast"

# Crear carpeta de salida si no existe
mkdir -p "$salida"

# Iterar sobre los IDs en el archivo lista_ids
while read -r id; do
    base="$carpeta_faa/$id.faa"
    
    if [[ -f "$base" ]]; then
        # Crear base de datos BLAST sin cambiar el nombre base
        makeblastdb -in "$base" -dbtype prot
        
        # Ejecutar blastp usando el mismo nombre base
        blastp -query "$query" -db "$base" -out "$salida/$id.tsv" -evalue 1e-5 -outfmt "6 qseqid sseqid pident length evalue bitscore"
        
        echo "✅ BLAST terminado para $id"
    else
        echo "⚠️ Archivo no encontrado: $base"
    fi
done < "$lista_ids"
