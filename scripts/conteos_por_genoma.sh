# Autor: Johanna Atenea
# Descripción: 
# Este script detecta cuantos genes de cada genoma estan presentes en cada una de las familias génicas
# ortologas identificadas en el pangenoma (resultados de GET-HOMOLOGUES)
# Directorio de entrada con los archivos .faa (archivos contenidos en la carpeta familias.tar.gz)
# Uso:bash conteos_por_genoma.sh familias/

INPUT_DIR=$1

# Carpeta de salida donde se guardarán los resultados
OUTPUT_DIR="conteos/"

# Crear la carpeta de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Procesar cada archivo .faa en la carpeta de entrada
for FILE in "$INPUT_DIR"/*.faa; do
    # Obtener el nombre de la familia sin extensión
    FAMILY_NAME=$(basename "$FILE" .faa)

    # Generar el conteo de genes por genoma y guardar en la carpeta de salida
    grep "^>" "$FILE" | sed 's/^>//' | awk -F'.' '{print $1"."$2}' | sort | uniq -c | awk '{print $2, $1}' > "$OUTPUT_DIR/${FAMILY_NAME}_conteo.tsv"


    echo "Procesado: $FAMILY_NAME"
done

echo "Todos los archivos han sido procesados. Los resultados están en $OUTPUT_DIR"
