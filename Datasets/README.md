# Dataset de Genomas de Cianobacterias

Este dataset contiene genomas anotados de **29 cepas distintas de cianobacterias**, identificadas por su ID numérico y nombre científico. Cada genoma fue anotado utilizando la plataforma **RAST (Rapid Annotations using Subsystems Technology)** y está almacenado en tres formatos diferentes.

El archivo comprimido `Cianobacterias.tar.gz` incluye todos los archivos correspondientes a estas cepas.

## Especies incluidas

A continuación se listan las cepas incluidas en el dataset:

- 3349875.4 — *Nostoc sp. C117*  
- 3349876.5 — *Nostoc sp. C110*  
- 211165.20 — *Chlorogloeopsis fritschii PCC 6912*  
- 3134896.7 — *Nostoc sp. UHCC 0302*  
- 3025190.14 — *Nostoc sp. UHCC 0926*  
- 449208.14 — *Nostoc cf. commune SO-36*  
- 2914041.10 — *Nostoc sp. UHCC 0870*  
- 2653204.7 — *Nostoc sphaeroides CCNUC1*  
- 2764711.14 — *Nostoc sp. MS1*  
- 1472755.9 — *Nostoc edaphicum CCNP1411*  
- 2576904.6 — *Nostoc sp. TCL26-01*  
- 2576903.5 — *Nostoc sp. C057*  
- 2576902.6 — *Nostoc sp. C052*  
- 2572090.7 — *Nostoc sp. TCL240-02*  
- 76335.23 — *Nostoc sp. ATCC 53789*  
- 2490939.10 — *Anabaena sp. YBS01*  
- 446679.11 — *Nostoc sphaeroides*  
- 1914872.23 — *Nodularia spumigena UHCC 0039*  
- 1618022.9 — *Nostoc sp. 'Lobaria pulmonaria (5183) cyanobiont'*  
- 1869241.20 — *Nostoc sp. CENA543*  
- 2038116.21 — *Nostoc flagelliforme CCNUN1*  
- 1751286.15 — *Nostoc sp. NIES-3756*  
- 1647413.14 — *Anabaena sp. WA102*  
- 272123.44 — *Anabaena cylindrica PCC 7122*  
- 28072.26 — *Nostoc sp. PCC 7524*  
- 317936.27 — *Nostoc sp. PCC 7107*  
- 46234.36 — *Anabaena sp. 90*  
- 63737.69 — *Nostoc punctiforme PCC 73102*  
- 103690.82 — *Nostoc sp. PCC 7120 = FACHB-418*

## Contenido del archivo comprimido

El archivo `Cianobacterias.tar.gz` contiene, para cada genoma, tres archivos generados por el sistema de anotación RAST:

- **`.txt`**: archivo de resumen con la información general de la anotación (nombre del organismo, estadísticas del genoma, número de genes, funciones asignadas, etc.).
- **`.faa`**: archivo FASTA que contiene las secuencias de proteínas codificadas por el genoma. Es útil para análisis funcionales, alineamientos y búsquedas de homología.
- **`.gbk`**: archivo en formato GenBank que incluye toda la información estructural y funcional del genoma, como localización de genes, funciones predichas, secuencia genómica, entre otros. Es compatible con diversas herramientas de bioinformática.

## Uso

Para descomprimir el archivo:

```bash
tar -xzvf Cianobacterias.tar.gz

