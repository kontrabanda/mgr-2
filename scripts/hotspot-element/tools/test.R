library(raster)
library(sp)
library(spatstat)
library(rgdal)

bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
city <- aggregate(bialystok)


crimes <- read.csv('../data/bialystok/swd/crimes_bialystok.csv')
coordinates(crimes) =~ GEO_LONG+GEO_LAT

plot(city)
plot(crimes, col='blue', pch=20, cex=0.5, add=T)


data <- read.csv('../data/points-in-hotspots/bialystokSWD/BOJ.csv')
data <- read.csv('../data/points-in-hotspots/bialystokSWD/INT.csv')



label.0.count <- sum(data$label == 0)
label.1.count <- sum(data$label == 1)

label.0.rate <- label.0.count/nrow(data)
label.1.rate <- label.1.count/nrow(data)

label.0 = data[data$label == 0, ]
label.1 = data[data$label == 1, ]

coordinates(label.0) =~ lng+lat
coordinates(label.1) =~ lng+lat

plot(city)
plot(label.0, col='blue', pch=20, cex=0.5, add=T)
plot(label.1, col='red', pch=20, cex=0.5, add=T)

