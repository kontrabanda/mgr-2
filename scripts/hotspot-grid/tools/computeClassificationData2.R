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

source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
source(file="./const.R")

#### variables
crimeCategoryName <- 'CHU'
cellSize <- 1000

#### extract data
bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
city <- aggregate(bialystok)

crimesData <- BialystokDataWithoutDuplicates()
crimesData$extractData()


print(paste('Computing hotspots grid for', crimesData$name , 'for category: ', crimeCategoryName, sep = ' '))

categories <- crimesData$categories

categoryData <- crimesData$getData(crimeCategoryName)
onlyCategoryData <- categoryData[categoryData$label == 1, ][1:2]

coordinates(onlyCategoryData) =~ lng+lat
projection(onlyCategoryData) = projection(city)
aeqdGlobal <- "+proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0"

onlyCategoryData <- spTransform(onlyCategoryData, aeqdGlobal)
city <- spTransform(city, aeqdGlobal)

rcity <- raster(city)
res(rcity) <- cellSize
rcity
r <- rasterize(city, rcity)
r

nc <- rasterize(onlyCategoryData, r, fun = 'count', background = 0)
ncrimes <- mask(nc, city)
plot(ncrimes)
plot(city, add = T)


df.crimes.grid <- as.data.frame(ncrimes, xy=T, na.rm=T)

#results$label <- ifelse(df.crimes.grid$layer > 1, 1, 0)
results <- df.crimes.grid
results <- results[order(results$layer, decreasing = T), ]

splitIndex <- ceiling(nrow(results) * 0.25)
splitValue <- results[splitIndex, ]$layer

results$label <- 0
results[results$layer >= splitValue & results$layer > 1, ]$label <- 1

sum(results$label == 1)/nrow(results)

randomizeResults <- results[sample(nrow(results)),]
resultPath <- paste('../data/hotspot-grid', crimesData$name, crimeCategoryName, sep = '/')
resultPath <- paste(resultPath, '.csv', sep = '')
write.csv(x = randomizeResults, file = resultPath)

#######################################################
head(results)
head(results[, c('x', 'y')])

points(results[, c('x', 'y')], pch = 4)








