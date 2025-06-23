# Dataset de Genomas de Cianobacterias

Esta carpeta contiene datos genómicos de **29 especies distintas de cianobacterias**, identificadas por su ID numérico y nombre científico. También se incluye el clúster responsable de la producción de **scytonemin**, junto con otros resultados necesarios para ejecutar los scripts en diferentes etapas del proyecto.
Los genomas fueron anotados utilizando la plataforma RAST (en su interfaz web).

A continuación se enumeran los archivos comprimidos que corresponden a los datos genómicos utilizados, junto con una breve descripción de su contenido.
## Archivos incluidos

### 🔹 `Cianobacterias.tar.gz`

Contiene los genomas anotados de las 29 cepas. Para cada genoma, incluye:

- `*.txt`: resumen de la anotación.
- `*.faa`: secuencias de proteínas en formato FASTA.
- `*.gbk`: archivo GenBank con información estructural y funcional.

Las especies incluidas en este archivo son:

| ID Numérico | Especie                                       |
|-------------|-----------------------------------------------|
| 3349875.4   | *Nostoc sp. C117*                             |
| 3349876.5   | *Nostoc sp. C110*                             |
| 211165.20   | *Chlorogloeopsis fritschii PCC 6912*         |
| 3134896.7   | *Nostoc sp. UHCC 0302*                        |
| 3025190.14  | *Nostoc sp. UHCC 0926*                        |
| 449208.14   | *Nostoc cf. commune SO-36*                   |
| 2914041.10  | *Nostoc sp. UHCC 0870*                        |
| 2653204.7   | *Nostoc sphaeroides CCNUC1*                   |
| 2764711.14  | *Nostoc sp. MS1*                              |
| 1472755.9   | *Nostoc edaphicum CCNP1411*                   |
| 2576904.6   | *Nostoc sp. TCL26-01*                         |
| 2576903.5   | *Nostoc sp. C057*                             |
| 2576902.6   | *Nostoc sp. C052*                             |
| 2572090.7   | *Nostoc sp. TCL240-02*                        |
| 76335.23    | *Nostoc sp. ATCC 53789*                       |
| 2490939.10  | *Anabaena sp. YBS01*                          |
| 446679.11   | *Nostoc sphaeroides*                          |
| 1914872.23  | *Nodularia spumigena UHCC 0039*              |
| 1618022.9   | *Nostoc sp. 'Lobaria pulmonaria (5183) cyanobiont'* |
| 1869241.20  | *Nostoc sp. CENA543*                          |
| 2038116.21  | *Nostoc flagelliforme CCNUN1*                 |
| 1751286.15  | *Nostoc sp. NIES-3756*                        |
| 1647413.14  | *Anabaena sp. WA102*                          |
| 272123.44   | *Anabaena cylindrica PCC 7122*                |
| 28072.26    | *Nostoc sp. PCC 7524*                         |
| 317936.27   | *Nostoc sp. PCC 7107*                         |
| 46234.36    | *Anabaena sp. 90*                             |
| 63737.69    | *Nostoc punctiforme PCC 73102*                |
| 103690.82   | *Nostoc sp. PCC 7120 = FACHB-418*             |

---

### 🔹 `familias.tar.gz`

Contiene las familias génicas homólogas obtenidas al correr **GET_HOMOLOGUES**, un software que compara las secuencias proteicas de múltiples genomas para identificar grupos de genes homólogos compartidos entre diferentes organismos.

### 🔹 `familias_filtradas.tar.gz`

Incluye las **familias filtradas** en las cuales se identificaron posibles **genes pertenecientes a familias génicas expandidas**. En los notebooks se hace referencia a esta carpeta como `familias_con_copias`.

### 🔹 `Genomas_con_scytonemin.tar.gz`

Contiene únicamente aquellos genomas del grupo de estudio donde se detectó la **presencia del clúster biosintético de scytonemin**, un pigmento producido por ciertas cianobacterias.

### 🔹 `scytonemin.faa`

Archivo FASTA con los **genes que conforman el clúster biosintético de scytonemin**. Estas secuencias fueron utilizadas como consultas en análisis BLAST para determinar la presencia o ausencia del clúster en los 29 genomas.

### 🔹 `resultados_umbrales.tar.gz` y `resultados_K_means.tar.gz`

Contienen los resultados de la **clasificación de genes candidatos a estar presentes en familias génicas expandidas**, utilizando dos métodos distintos:

- `resultados_K_means.tar.gz`: basado en el algoritmo de **K-means**.
- `resultados_umbrales.tar.gz`: basado en el **método de puntos de corte**.

En los notebooks se hace referencia a estas carpetas como `K_means_results` y `clasificación`, respectivamente.

### 🔹 `posiciones_scytonemin.txt`

Archivo de texto con las **posiciones genómicas** de los genes que conforman el clúster de scytonemin, en aquellos genomas donde se detectó su presencia.

### 🔹 `pangenome_matriz_t0.tr.csv`

Archivo CSV que contiene la **matriz de presencia/ausencia** para el grupo de estudio.  
Cada fila representa una familia génica ortóloga, y cada columna corresponde a un genoma.  
Los valores indican si una familia está presente (`1`) o ausente (`0`) en cada genoma.

---

### 🔹 `longitudes_copias.csv`

Contiene las **longitudes de los genomas del grupo de estudio**, medidas en **kilobases (kb)**.  
Este archivo se utiliza para normalizar análisis como la proporción de genes duplicados por tamaño de genoma.

---

### 🔹 `ids_scytonemin.txt`

Archivo de texto con los **IDs de los genomas** en los que se detectó la **presencia del clúster biosintético de scytonemin**.  
Este listado se usa para filtrar análisis posteriores centrados en dichos genomas.

---


## Uso

Para descomprimir cualquier archivo `.tar.gz`, utiliza:

```bash
tar -xzvf nombre_del_archivo.tar.gz
``
