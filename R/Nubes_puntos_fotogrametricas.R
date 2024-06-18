# Instalamos paquetes 
install.packages('lidR')
install.packages('ggplot2')

# Cargamos los paquetes
library(lidR)
library(ggplot2)

# Establecemos la ruta de la nube
ruta_nube <- "C:/Users/users/Downloads/Nube_puntos_olivar.laz"

# Leemos la nube de puntos con la ruta establecida
las <- readLAS(ruta_nube)

# Leemos la nube de puntos con la ruta directamente
las <- readLAS("C:/Users/users/Downloads/Nube_puntos_olivar.laz")

# Imprimimos la información de la nube de puntos
print(las)

# Comprobamos la nube de puntos
las_check(las)

# Visualizamos la nube de puntos fotogramétrica con color RGB
plot(las, color ="RGB")

# Visualizamos la nube de puntos fotogramétrica con color RGB con ejes y fondo blanco
plot(las, color ="RGB", bg = "white", axis = TRUE)

# Voxelizado de nubes de puntos, con un paso de 0.04 metros
las_voxelizado<- voxelize_points(las, 0.04)

# Imprimimos la información de la nube de puntos voxelizada
print(las_voxelizado)

# Visualizamos la nube de puntos voxelizada
plot(las_voxelizado)

# Clasificamos los puntos de terreno con un tamaño de ventana de 5 metros y una altura de umbral de 0.25 metros
las <- classify_ground(las, algorithm = pmf(ws = 5, th = 0.25))

# Guardamos la nube de puntos
writeLAS(las, "D:/Nube_olivar_25830_clasificada.laz")

# Visualización de la clasificación
plot(las, color = "Classification", size = 3, bg = "white") 

# Creamos la función para visualización en 2D
plot_crossection <- function(las,
                             p1 = c(min(las@data$X), mean(las@data$Y)),
                             p2 = c(max(las@data$X), mean(las@data$Y)),
                             width = 4, colour_by = NULL)
{
  colour_by <- rlang::enquo(colour_by)
  data_clip <- clip_transect(las, p1, p2, width)
  p <- ggplot(data_clip@data, aes(X,Z)) + geom_point(size = 0.5) + coord_equal() + theme_minimal()

  if (!is.null(colour_by))
    p <- p + aes(color = !!colour_by) + labs(color = "")

  return(p)
}

# Establecemos las coordenadas de los puntos 1 y 2
P1<- c(348926.51225 , 4199858.43604)
P2<- c(348940.3040 , 4199857.7980)

# Visualizamos la nube de puntos en 2 D
plot_crossection(las, p1 = P1 , p2 = P2, colour_by = factor(Classification))

# Generación del MDT
mdt <- rasterize_terrain(las, algorithm = tin(), res = 0.1)

# Visualizamos el MDT 
plot(mdt, col =gray(0:30/30))

# Visualizamos el MDT en 3D
plot_dtm3d(mdt, bg = "white")

# Instalamos y cargamos la libreria Terra
install.packages("terra")
library(terra)

# Guardamos el raster
writeRaster(mdt, "H:/Curso_fotogrametria/MDT.tiff")

# Normalizado de la nube de puntos
las_normalizado <- las - mdt

# Visualización de la nube de puntos normalizada
plot(las_normalizado, color ="RGB", bg = "white", axis = TRUE)

# Rasterización de la nube de puntos normalizada
chm <- rasterize_canopy(las_normalizado, res = 0.03, 
                        algorithm = p2r(subcircle = 0.10))

# Creamos la paleta de colores
col <- height.colors(25)

# Visualizamos la representación en 2D
plot(chm, col=col)

# Localizamos árboles
ttops <- locate_trees(las, lmf(ws = 4.2))

# Visualizamos la nube de puntos
x <- plot(las, bg = "white", size = 0.05))

# Visualizamos la localización de ttops
add_treetops3d(x, ttops)

# Imprimimos la información de ttops
print(ttops)

# Instalamos el paquete raster
install.packages("raster")

# Cargamos el paquete
library(raster)

# Transformamos el mdt a Spatraster
mdt <- raster(mdt)

# Duplicamos ttops
ttops_normalizado <- ttops

# Realizamos el calculo 
ttops_normalizado[2]  <- ttops_normalizado[2] - mdt

# Printeamos Ttops normalizado
print(ttops_normalizado)
