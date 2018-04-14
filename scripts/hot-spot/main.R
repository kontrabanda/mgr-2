library(raster)
library(sp)
library(latticeExtra)
library(RColorBrewer)
library(ggplot2)
library(maptools)
library(spatstat)

source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
source(file="./const.R")

bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
city <- aggregate(bialystok)

plot(city)

crimesData <- BialystokDataWithoutDuplicates()
crimesData$extractData()

categories <- crimesData$categories

categoryData <- crimesData$getData('CHU')
onlyCategoryData <- categoryData[categoryData$label == 1, ][1:2]

coordinates(onlyCategoryData) =~ lng+lat
projection(onlyCategoryData) = projection(city)

cityOwin <- as.owin(city)
pts <- coordinates(onlyCategoryData)
p <- ppp(pts[,1], pts[,2], window = cityOwin)

ds_0.1 <- density(p, adjust = 0.1, kernel="gaussian", window = kernel)

r <- raster(ds_0.1)
plot(r)

unique(r@data@values)

r@data@values[is.na(r@data@values)] <- 0
valuesTemp <- r@data@values

sortValues <- order(valuesTemp)
nr <- length(sortValues)
i <- round(0.9 * length(sortValues))
val <- sortValues[i]


r@data@values <- ifelse(valuesTemp > 10000000, 1, 0)
plot(r)
plot(city, add=T)
r@data@values <- valuesTemp


max(valuesTemp)
mean(valuesTemp)

10000000
