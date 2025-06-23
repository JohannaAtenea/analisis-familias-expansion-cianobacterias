#!/bin/bash
# Autor: Johanna Atenea
# Descripción:
# ESTE SCRIPT DEVUELVE LAS POSICIONES DE LOS GENES QUE HAYAN SIDO CLASIFICADOS COMO PERTENECIENTES A ALGUNA FAMILIA GENICA
# PARA CADA GENOMA Y  DEVUELVE SU POSICION EN PARES DE BASES
# Uso: bash obtener_posiciones.sh ids_copias.txt
# Salida: posiciones_umbrales.csv o posciones_k_means.csv respectivamente.
# Variables de entrada

IDS_FILE=$1
GENES_COPIA_FILE="genes_secundarios_umbrales.csv" # CAMBIA POR EL OUTPUT QUE TE HAYA DEVUELTO K-means O EL MÉTODO DE UMBRALES 
ANNOTATION_DIR="/files/atenea/bacterias/Cianobacterias_corregidas/Cianobacterias_RAST"  # Cambia esta rutA por donde se tenga almacenado los genomas del grupo de estudio
# Archivo de salida
OUTPUT_FILE="posiciones_umbrales.csv"
> "$OUTPUT_FILE"  # Limpiar el archivo de salida
echo -e "genome_id\tgen_id\tcontig_id\tstart\tstop" >> "$OUTPUT_FILE"
# Leer el archivo ids.txt y procesar cada línea
while IFS=$' ' read -r genome_id; do
    genome_id=$(echo "$genome_id" | xargs)  # Eliminar espacios al principio y al final
    echo "Procesando el genoma: $genome_id con archivo de anotación $genome_id.txt"

    # Buscar genes duplicados en genes_copia_sin_id.txt para este genome_id
     genes_copia=$(grep "^$genome_id" "$GENES_COPIA_FILE" | cut -f2)
    
    # Verificar si se encontraron genes duplicados
    if [[ -n "$genes_copia" ]]; then
        # Separar los genes duplicados en un array
        IFS=',' read -r -a gene_array <<< "$genes_copia"
        echo "Genes duplicados encontrados: ${gene_array[@]}"
        
        # Ruta al archivo de anotación
        annotation_file="$ANNOTATION_DIR/${genome_id}.txt"
        
	#formato requerido para gene_array
	cleaned_genes=()
	for gene in "${gene_array[@]}"; do
    		# Limpia cada elemento del array
   		 gene=$(echo "$gene" | tr -d '\r\n\t' | sed 's/^[ \t]*//;s/[ \t]*$//' | tr -d ',')
    		cleaned_genes+=("$gene")
	done
        # Verificar si el archivo de anotación existe
        if [[ -f "$annotation_file" ]]; then
        #    echo "Leyendo archivo de anotación: $annotation_file"
            
            # Leer el archivo de anotación
            while IFS=$'\t' read -r contig_id feature_id type location start stop strand function; do
                # Limpiar el feature_id para compararlo con los genes duplicados
                # Limpiar el feature_id para que coincida con el formato deseado
    		feature_id_clean1=$(echo "$feature_id" | sed -E 's/^fig\|([0-9]+\.[0-9]+)\.peg\.(.*)$/\1.\2/')
    		feature_id_clean=$(echo "$feature_id_clean1" | cut -d '.' -f 3)  # Corrección: eliminación del espacio antes del igual
    		contig_id_clean=$(echo "$contig_id" | sed -E 's/^gi\|[0-9]+\|gb\|(.*)\.[0-9]+\|$/\1/')

	        # Si el feature_id no coincide con el formato, se ignora
                if [[ -z "$feature_id_clean" ]]; then
                    continue
                fi
		echo "Procesando feature_id: $feature_id_clean"
                
                # Para cada gene duplicado, verificar coincidencia con feature_id
                if printf "%s\n" "${cleaned_genes[@]}" | grep -q "^$feature_id_clean$"; then
		    echo -e "$genome_id\t$feature_id_clean\t$contig_id_clean\t$start\t$stop" >> "$OUTPUT_FILE"
    		    echo "Coincidencia encontrada para el genoma $genome_id: $feature_id en $contig_id"
		fi

            done < "$annotation_file"
        else
            echo "Archivo de anotación $annotation_file no encontrado para el genoma $genome_id."
        fi
    else
        echo "No se encontraron genes duplicados para el genoma $genome_id."
    fi
done < "$IDS_FILE"

echo "Proceso completado. Resultados almacenados en $OUTPUT_FILE."
