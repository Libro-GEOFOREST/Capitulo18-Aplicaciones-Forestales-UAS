
Carlos MARTÍN CORTÉS, Borja GARCÍA PASCUAL, Mauricio ACUNA, Guillermo PALACIOS RODRÍGUEZ, Miguel Ángel LARA GÓMEZ, Rafael Mª NAVARRO CERRILLO

# Capitulo 18: Aplicaciones Forestales UAS

## 1. Tratamiento de Nubes de Puntos con lidR: Análisis de un Olivar

Este ejemplo se centra en el análisis de una zona de olivar utilizando datos fotogramétricos de alta resolución capturados mediante sistemas aéreos no tripulados (UAS), se mostrará cómo se procesa y analiza la información capturada con la ayuda
de la librería lidR en el entorno de programación R.

### Objetivos:

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

### Materiales Necesarios:
- Nube de puntos de olivar
- Software RStudio
- Guía de referencia rápida para la librería lidR

![](./Auxiliares/UAS.jpg)



# 2. Cálculo de Índices de vegetación a partir de imágenes multiespectrales y creación de mapas.

Este ejemplo se centra en el análisis de imágenes multiespectrales obtenidas por UAS para calcular índices de vegetación y crear mapas temáticos. A demás se aprenderá a como automatizar este proceso, todo se realizará desde el entorno de programación R.

### Objetivos:
- Familiarizarse con las imágenes multiespectrales y su aplicación en la monitorización de la vegetación.
- Familiarización con los índices de vegetación más comunes.
- Aprender a calcular índices de vegetación y creación de funciones para poder calcularlos.
- Desarrollar habilidades en el manejo de Sistemas de Información Geográfica desde un entorno de programación para la creación de mapas temáticos basados en los índices calculados.
- Interpretación de los mapas generados.

### Materiales Necesarios:
- Orto mosaicos multi-espectrales
- Software RStudio



#### Instalación y carga de librerías

Para trabajar con gráficos y datos geoespaciales en R, primero debemos instalar, y luego cargar varias librerías esenciales.

En este ejemplo, utilizaremos ggplot2, terra y sf. A continuación, se muestra cómo instalar estas librerías (si aún no las tienes instaladas) y cómo cargarlas para su uso.

##### Instalación de las librerías

Si no tienes estas librerías instaladas en tu entorno de R, puedes instalarlas utilizando el comando **install.packages()**.

```r
#Instalamos librerias
install.packages("ggplot2")
install.packages("terra")
install.packages("sf")
install.packages('ggspatial')
```

##### Carga de las librerías

Una vez instaladas las librerías, podemos cargarlas en nuestro entorno de trabajo usando la función **library()**.

```r
# Cargamos librerias
library(ggplot2)
library(terra)
library(sf)
library(ggspatial)
```

##### ggplot2

Esta librería es parte del conjunto de herramientas tidyverse y se utiliza para crear gráficos de alta calidad en R. Ofrece una forma consistente y poderosa de crear una amplia variedad de gráficos de manera eficiente. Url de información: (https://ggplot2.tidyverse.org/)[https://ggplot2.tidyverse.org/]

A continuación se puede observar el **CHEATSHEET**:

![](./Auxiliares/Cheatsheet_ggplot.png)

##### terra

Esta es una librería diseñada para el análisis y manejo de datos raster. Los datos raster son representaciones matriciales de datos espaciales. Url de información: (https://rspatial.org/pkg/)[https://rspatial.org/pkg/]

##### sf

Esta librería facilita el manejo de datos espaciales simples, especialmente datos vectoriales. sf soporta el uso de geometrías (puntos, líneas , polígonos). Url de información: (https://r-spatial.github.io/sf/)[https://r-spatial.github.io/sf/]

A continuación se puede observar el **CHEATSHEET**:

![](./Auxiliares/Cheatsheet_sf.png)

##### ggspatial

Esta librería proporciona funciones adicionales para trabajar con datos geoespaciales en ggplot2, permitiendo agregar elementos como coordenadas, escalas y mapas base a los gráficos creados con ggplot2. Url de información: (https://paleolimbot.github.io/ggspatial/)[ttps://paleolimbot.github.io/ggspatial/]

#### ¿Qué es una imagen multiespectral?

Para poder comenzar, primero realizaremos una breve explicación de que es una imagen multiespectral:

Una imagen multiespectral es una representación de una escena capturada en múltiples bandas espectrales. A diferencia de una imagen convencional, que contiene tres bandas (rojo, verde y azul), una imagen multiespectral puede incluir varias bandas adicionales, cada una capturando información en diferentes rangos del espectro electromagnético.

En el caso de este ejemplo trabajaremos con una imagen multiespectral que contiene cuatro bandas: 
- Banda 1: Rojo
- Banda 2: Verde
- Banda 3: Azul
- Banda 4: Infrarrojo

#### Apertura y visualización de una imagen multiespectral

En esta parte del ejemplo, comenzaremos por abrir una imagen multiespectral y visualizarla.

##### Carga de una imagen multiespectral

#### Recorte de la imagen multiespectral para una zona de estudio

#### Creación de mapas
