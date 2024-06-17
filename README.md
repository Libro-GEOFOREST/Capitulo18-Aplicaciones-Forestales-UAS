
Carlos MARTÍN CORTÉS, Guillermo PALACIOS RODRÍGUEZ, Miguel Ángel LARA GÓMEZ, Rodrigo ARTHUS BACOVICH, Rafael Mª NAVARRO CERRILLO

# Capitulo 18: Aplicaciones Forestales UAS

## Tratamiento de Nubes de Puntos con lidR: Análisis de un Olivar

Este ejemplo se centra en el análisis de una zona de olivar utilizando datos fotogramétricos de alta resolución capturados mediante sistemas aéreos no tripulados (UAS), se mostrará cómo se procesa y analiza la información capturada con la ayuda
de la librería lidR en el entorno de programación R.

#### Objetivos:

- Comprender los principios básicos de la fotogrametría y su aplicación en entornos forestales
- Aprender a realizar un plan de vuelo para la captura de datos fotogramétricos
- Aprender a manejar y procesar datos fotogramétricos utilizando UAS
- Utilizar la librería lidR para:
  
1. Comprobación de nubes de puntos
2. Visualización de nubes de puntos
3. Voxelización de nubes de puntos
4. Clasificación del terreno
5. Creacción de modelos digitales
6. Detección de arboles
7. Extracción de datos dasométricos

#### Materiales Necesarios:
- Nube de puntos de olivar
- Software RStudio
- Guía de referencia rápida para la librería lidR

![](./Auxiliares/UAS.jpg)

### Introducción

lidR es un paquete de R para manipular y visualizar datos de nubes de puntos para la realización de aplicaciones forestales.

El paquete es completamente de código abierto y está integrado dentro del ecosistema geoespacial de R.

Url de información: [https://r-lidar.github.io/lidRbook/]

### Instalación de paquete

En el entorno de R, los paquetes son conjuntos de funciones y datos que extienden las capacidades del lenguaje. Estos paquetes se utilizan para realizar tareas específicas, como análisis de datos, visualización, etc.

Antes de poder trabajar con un paquete en R, lo primero que tendremos que realizar es la instalación de este paquete. Para esta instalación tendremos que utilizar el siguiente comando: *install.packages()*

Dentro de este comando tendremos que poner el nombre del paquete entre comillas (“).

De la siguiente manera se instalará el paquete lidR y ggplot2:

```r
# Instalamos paquetes 
install.packages('lidR')
install.packages('ggplot2')
```

Después de instalar el paquete en R con install.packages(“lidR”), podemos cargarlo en nuestra sesión de R utilizando la función *library()*.

A diferencia de la instalación de paquetes, dentro de este comando no se tiene que poner el nombre del paquete entre comillas, si no que escribiremos el nombre sin comillas.

La función *library()* se utiliza para cargar paquetes previamente instalados en R, permitiendo acceder a sus funciones y datos. En el caso del paquete lidR, podemos cargarlo de la siguiente manera:

```r
# Cargamos los paquetes
library(lidR)
library(ggplot2)
```

### Carga de nube de puntos

El primer paso para la utilización de este paquete es la carga de nube de puntos.

Lo primero que debemos de conocer es que necesitamos tener la nube de puntos en formato *.las* o *.laz*.

Para cargar una nube de puntos se utiliza la función *readLAS()*.

Dentro de la función tendremos que poner la dirección del archivo completa, para ello tendremos que copiar ruta de acceso.

Una vez copiada la dirección, debería de aparecer de la siguiente manera: *C:\Users\users\Downloads\Nube_puntos_olivar.laz*

Es importante saber que, en R, las rutas que metemos en el programa nunca deberán ir con la siguiente barra: \, si no que deberían ir con la barra hacia el otro lado, es decir: /, que esta sería la línea divisoria.

Esta ruta la tendremos que meter en formato texto a R, por lo que tendrá que ir entre comillas.

Realizaremos una cadena de caracteres que contenga esta información.

En tu caso dentro tendrás que poner la ruta donde almacenes la nube de puntos.

```r
# Establecemos la ruta de la nube
ruta_nube <- "C:/Users/users/Downloads/Nube_puntos_olivar.laz"
```

Una vez que tenemos esta cadena de texto utilizar la función readLAS() de la siguiente manera:

```r
# Leemos la nube de puntos con la ruta establecida
las <- readLAS(ruta_nube)
```

O lo que seria lo mismo:

```r
# Leemos la nube de puntos con la ruta directamente
las <- readLAS("C:/Users/users/Downloads/Nube_puntos_olivar.laz")
```

A continuación, mostraremos un resumen de la información de esta nube de puntos con la función *print()*.

Cuando aplicamos *print()* a la nube de puntos, mostrará una representación legible de ese objeto. Esto es útil para inspeccionar el contenido de la nube de puntos y verificar si se han cargado correctamente, entre otras cosas.

```r
# Imprimimos la información de la nube de puntos
print(las)
```

```r annotate
## class        : LAS (v1.2 format 2)
## memory       : 21.3 Mb 
## extent       : 348926.1, 348941.3, 4199851, 4199865 (xmin, xmax, ymin, ymax)
## coord. ref.  : ETRS89 / UTM zone 30N 
## area         : 204.5 m²
## points       : 429 thousand points
## density      : 2097.62 points/m²
## density      : 2097.62 pulses/m²
```

Un primer paso importante en el procesamiento de datos de nubes de puntos es garantizar que los datos estén completos y sean válidos. Para eso utilizaremos la función *las_check()* para realizar una inspección de la nube de puntos.

Esta función comprueba si un objeto LAS cumple con las especificaciones LAS de ASPRS y si es válido para su procesamiento, dando advertencias en caso contrario.

```r
# Comprobamos la nube de puntos
las_check(las)
```

```r annotate
##  Checking the data
##   - Checking coordinates...[0;32m ✓[0m
##   - Checking coordinates type...[0;32m ✓[0m
##   - Checking coordinates range...[0;32m ✓[0m
##   - Checking coordinates quantization...[0;32m ✓[0m
##   - Checking attributes type...[0;32m ✓[0m
##   - Checking ReturnNumber validity...[0;32m ✓[0m
##   - Checking NumberOfReturns validity...[0;32m ✓[0m
##   - Checking ReturnNumber vs. NumberOfReturns...[0;32m ✓[0m
##   - Checking RGB validity...[0;32m ✓[0m
##   - Checking absence of NAs...[0;32m ✓[0m
##   - Checking duplicated points...
##  [1;33m   ⚠ 39947 points are duplicated and share XYZ coordinates with other points[0m
##   - Checking degenerated ground points...[0;37m skipped[0m
##   - Checking attribute population...
##  [0;32m   🛈 'EdgeOfFlightline' attribute is not populated[0m
##   - Checking gpstime incoherances[0;37m skipped[0m
##   - Checking flag attributes...[0;32m ✓[0m
##   - Checking user data attribute...[0;32m ✓[0m
##  Checking the header
##   - Checking header completeness...[0;32m ✓[0m
##   - Checking scale factor validity...[0;32m ✓[0m
##   - Checking point data format ID validity...[0;32m ✓[0m
##   - Checking extra bytes attributes validity...[0;32m ✓[0m
##   - Checking the bounding box validity...[0;32m ✓[0m
##   - Checking coordinate reference system...[0;32m ✓[0m
##  Checking header vs data adequacy
##   - Checking attributes vs. point format...[0;32m ✓[0m
##   - Checking header bbox vs. actual content...[0;32m ✓[0m
##   - Checking header number of points vs. actual content...[0;32m ✓[0m
##   - Checking header return number vs. actual content...[0;32m ✓[0m
##  Checking coordinate reference system...
##   - Checking if the CRS was understood by R...[0;32m ✓[0m
##  Checking preprocessing already done 
##   - Checking ground classification...[0;31m no[0m
##   - Checking normalization...[0;31m no[0m
##   - Checking negative outliers...[0;32m ✓[0m
##   - Checking flightline classification...[0;32m yes[0m
##  Checking compression
##   - Checking attribute compression...
##    -  ScanDirectionFlag is compressed
##    -  EdgeOfFlightline is compressed
##    -  Classification is compressed
##    -  Synthetic_flag is compressed
##    -  Keypoint_flag is compressed
##    -  Withheld_flag is compressed
##    -  ScanAngleRank is compressed
##    -  UserData is compressed
##    -  PointSourceID is compressed
```

Una vez comprobadas las especificaciones de la nube de puntos, pasaremos a visualizarla para ello utilizaremos la función *plot()*, dentro de esta función podemos visualizar la nube de puntos según su campo, pero en este ejemplo se mostrará la función en color RGB.

Importante saber que los funciona la visualización con color nubes de puntos que contienen información de color, como son las nubes de puntos fotogramétricas.

```r
# Visualizamos la nube de puntos fotogramétrica con color RGB
plot(las, color ="RGB")
```
