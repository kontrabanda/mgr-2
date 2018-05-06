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

#source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
#source(file="./const.R")

#### variables
#crimeCategoryName <- 'RD'
#cellSize <- 200

#### extract data
#bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
#bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
#city <- aggregate(bialystok)

#crimesData <- BialystokDataWithoutDuplicates()
#crimesData$extractData()


print(paste('Computing hotspots grid for', crimesData$name , 'for category: ', crimeCategoryName, 'for cell size: ', cellSize, sep = ' '))

plotDirPath <- paste('../plot/hotspot-grid', crimesData$name, crimeCategoryName, sep = '/')
dir.create(plotDirPath, recursive = T)

categoryData <- crimesData$getData(crimeCategoryName)
onlyCategoryData <- categoryData[categoryData$label == 1, ][1:2]

coordinates(onlyCategoryData) =~ lng+lat
projection(onlyCategoryData) = projection(city)
aeqdGlobal <- "+proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0"

png(paste(plotDirPath, '/crimesBeforeTransform.png', sep = ''), width = 3000, height = 2000)
plot(city)
plot(onlyCategoryData, add=T)
dev.off()


onlyCategoryData <- spTransform(onlyCategoryData, aeqdGlobal)
cityTr <- spTransform(city, aeqdGlobal)

rcity <- raster(cityTr)
res(rcity) <- cellSize
rcity
r <- rasterize(cityTr, rcity)
r

nc <- rasterize(onlyCategoryData, r, fun = 'count', background = 0)
ncrimes <- mask(nc, cityTr)

png(paste(plotDirPath, '/ncrimes.png', sep = ''), width = 3000, height = 2000)
#plot(city)
plot(ncrimes)
dev.off()



df.crimes.grid <- as.data.frame(ncrimes, xy=T, na.rm=T)

#results$label <- ifelse(df.crimes.grid$layer > 1, 1, 0)
results <- df.crimes.grid
results <- results[order(results$layer, decreasing = T), ]

splitIndex <- ceiling(nrow(results) * 0.25)
splitValue <- results[splitIndex, ]$layer

results$label <- 0
results[results$layer >= splitValue & results$layer > 1, ]$label <- 1

sum(results$label == 1)/nrow(results)

ncrimes.test <- ncrimes
values(ncrimes.test) <- ifelse(values(ncrimes.test) >= splitValue & values(ncrimes.test) > 1, 1, 0)
ncrimes.test.poly <- as(ncrimes.test,"SpatialPolygons")
png(paste(plotDirPath, '/grids.png', sep = ''), width = 3000, height = 2000)
#plot(ncrimes.test)
plot(cityTr)
plot(ncrimes.test, col = c('#b7d7e8', '#f7cac9'), add = T)
plot(onlyCategoryData, add=T)
dev.off()

randomizeResults <- results[sample(nrow(results)),]
resultPath <- paste('../data/hotspot-grid', crimesData$name, crimeCategoryName, sep = '/')
resultPath <- paste(resultPath, '.csv', sep = '')
write.csv(x = randomizeResults, file = resultPath)








