library(raster)
library(sp)
library(latticeExtra)
library(RColorBrewer)
library(ggplot2)
library(maptools)
library(spatstat)
library(rgdal)
library(spatialEco)
library(dismo)
library(dplyr)

source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
source(file="./data/bournemouth/BournemouthDataWithoutDuplicates.R")
source(file="./const.R")

set.seed(123)

## init Bialystok
bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
city <- aggregate(bialystok)
cellSize <- 200
cityName <- 'bialystok'

## init Bournemouth
bournemouth <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
bournemouth <- spTransform(bournemouth, CRS("+init=epsg:4326"))
city <- aggregate(bournemouth)
cellSize <- 200
cityName <- 'bournemouth'


aeqdGlobal <- "+proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0"


cityTr <- spTransform(city, aeqdGlobal)

rcity <- raster(cityTr)
res(rcity) <- cellSize
rcity
r <- rasterize(cityTr, rcity)
r

r.df <- as.data.frame(r, xy=T, na.rm=T)

label.1.count <- ceiling(0.2 * nrow(r.df))

label.1.random.index <- sample(nrow(r.df), size = label.1.count)

label.0.df <- data.frame(r.df[-label.1.random.index, ], label = 0)
label.1.df <- data.frame(r.df[label.1.random.index, ], label = 1)

results <- rbind(label.0.df, label.1.df)
randomizeResults <- results[sample(nrow(results)), ]

filePath <- paste('../data/hotspot-grid/random/', cityName,'Random.csv', sep = '')
write.csv(x = randomizeResults, file = filePath)






