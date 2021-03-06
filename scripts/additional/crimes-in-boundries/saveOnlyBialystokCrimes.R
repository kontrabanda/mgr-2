library(raster)
library(sp)
library(latticeExtra)
library(RColorBrewer)
library(ggplot2)
library(maptools)
library(spatstat)

print('Computing crimes in Bialystok...')
print(paste('Start at:', Sys.time(), sep = ' '))

bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
onlyBialystok <- aggregate(bialystok)

crime <- read.csv("../data/additional/crimes/crimes-bialystok-rsow.csv", sep = "|")
crime <- crime[!is.na(crime$LAT)&!is.na(crime$LNG), ]

# zmiana z , na . w danych (inaczej traktowane są jako string)
crime$LAT <- as.numeric(gsub(",", ".", gsub("\\.", "", crime[["LAT"]])))
crime$LNG <- as.numeric(gsub(",", ".", gsub("\\.", "", crime[["LNG"]])))

coordinates(crime) =~ LNG+LAT
projection(crime) = projection(bialystok)

crimeBialystok <- intersect(crime, onlyBialystok)
crimeBialystokDF <- data.frame(crimeBialystok)
write.csv(crimeBialystokDF, file = "../data/bialystok/crimes_bialystok.csv", sep = "|")

print(paste('Finish at:', Sys.time(), sep = ' '))
print('Finish computing.')