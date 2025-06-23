# Scripts de análisis genómico en Bash

Este repositorio contiene una colección de scripts Bash diseñados para el análisis de genomas de cianobacterias, con énfasis en la identificación y caracterización de familias génicas, así como en la detección del clúster biosintético de **scytonemin**.

---

## Requisitos

- Un sistema con **Bash** instalado (la mayoría de los sistemas Unix/Linux lo incluyen por defecto).
- Algunos scripts requieren tener **BLASTp** instalado y accesible desde la línea de comandos.

---

## Ejecución

La mayoría de los scripts se pueden ejecutar directamente desde la terminal usando:

```bash
bash nombre_del_script.sh

## Descripción de los scripts

### `obtener_posiciones.sh`
Este script devuelve las **posiciones en pares de bases** de los genes que hayan sido clasificados como pertenecientes a alguna **familia génica**, para cada genoma del grupo de estudio.

---

### `scytonemin.sh`
Compara el **clúster biosintético de scytonemin** (`scytonemin.faa`) contra los genomas del grupo de estudio utilizando **BLASTp**, identificando posibles genes homólogos en los genomas.

---

### `detectar_scytonemin.sh`
Filtra los resultados generados por `scytonemin.sh`, conservando únicamente los genes que cumplen con los siguientes criterios de alineamiento:

- **Porcentaje de identidad (pident) ≥ 80%**
- **E-value < 1e-10**

---

### `matriz_conteos.sh`
Construye una **matriz de abundancia** específica para los genes del **clúster de scytonemin**, considerando únicamente los genomas en los que se detectó dicho clúster.

---

### `crear_diccionario.sh`
Genera un **diccionario JSON** que almacena las **posiciones** (en bases) de los genes del clúster de scytonemin en cada genoma donde este clúster fue detectado.

---

### `conteos_por_genoma.sh`
Cuenta **cuántos genes pertenecen a cada familia génica** (definida por GET-HOMOLOGUES) en cada genoma individual. El resultado es usado para construir matrices de abundancia.

---

### `matriz.sh`
Usa los conteos por genoma para construir una **matriz de abundancia completa**, que resume la distribución de todas las familias génicas entre los distintos genomas del estudio.

---

### `script_obtener_num_genes.sh`
Cuenta el **número total de genes** de cada genoma usando archivos `.gbk` ubicados en la carpeta `Cianobacterias/`.  
Estos datos se utilizan para calcular las diferencias en número de genes entre familias génicas expandidas y el total por genoma.

---
