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


set.seed(123)
###### bialystok
bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
city <- aggregate(bialystok)
cityName <- 'bialystok'
###### bournemouth
bournemouth <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
bournemouth <- spTransform(bournemouth, CRS("+init=epsg:4326"))
city <- aggregate(bournemouth)
cityName <- 'bournemouth'

label.0.points <- spsample(city, 10000, "random")
label.1.points <- spsample(city, 10000, "random")


label.0.points.df <- data.frame(lng = label.0.points$x, lat = label.0.points$y, label = 0)
label.1.points.df <- data.frame(lng = label.1.points$x, lat = label.1.points$y, label = 1)


results <- rbind(label.0.points.df, label.1.points.df)
randomizeResults <- results[sample(nrow(results)), ]

filePath <- paste('../data/points-in-hotspots/random/', cityName,'Random.csv', sep = '')
write.csv(x = randomizeResults, file = filePath)
