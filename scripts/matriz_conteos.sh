#!/bin/bash
#  Autor: Johanna Atenea
# Descripción:
# Este script realiza la matriz de abundancia de aquellos genes pertenecientes al clíster responsable de producir escitonemina
# , lo hace exclusivamente para aquellas cianobacerias del grupo de estudio para los cuales se detectó
# presencia de scytonemin y para correrlo es necesario los resultados que devuelve el script 'scytonemin.sh'
# Uso : bash matriz_conteos.sh 
 
# === Configuración ===
carpeta_resultados="resultados_blast"
salida_matriz="matriz_conteos.tsv"
evalue_umbral="1e-5"

# Obtener todos los genes qseqid únicos de todos los archivos
genes=()
for archivo in "$carpeta_resultados"/*.tsv; do
    cut -f1 "$archivo"
done | sort | uniq > genes_tmp.txt

# Leer genes en array
mapfile -t genes < genes_tmp.txt
rm genes_tmp.txt

# Escribir encabezado
echo -ne "genoma" > "$salida_matriz"
for gen in "${genes[@]}"; do
    echo -ne "\t$gen">>"$salida_matriz"
done

# Iterar sobre archivos de resultados
for archivo in "$carpeta_resultados"/*.tsv; do
    genoma=$(basename "$archivo" .tsv)
    echo -ne "$genoma" >> "$salida_matriz"

    for gen in "${genes[@]}"; do
        # Filtrar líneas con ese gen y evalue <= umbral
        best_hit=$(awk -v g="$gen" -v ev="$evalue_umbral" '$1==g && $5<=ev' "$archivo" | sort -k6,6nr | head -n1)

        if [[ -n "$best_hit" ]]; then
            # Extraer pident
            pident=$(echo "$best_hit" | awk '{print $3}')
            echo -ne "\t$pident" >> "$salida_matriz"
        else
            echo -ne "\t0" >> "$salida_matriz"
        fi
    done

    echo "" >> "$salida_matriz"
done
