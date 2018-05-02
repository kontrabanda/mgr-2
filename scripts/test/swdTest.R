library(raster)
library(sp)
library(maptools)
library(spatstat)
library(rgdal)
library(plyr)

crimes.df <- read.csv('../data/additional/crimes/crimes-bialystok-swd.csv', sep = '|')

unique(crimes.df$GRUPA_KOD)
length(unique(crimes.df$ID))

poland <- shapefile('../data/polska/wojewodztwa/wojewodztwa.shp')
poland <- spTransform(poland, CRS("+init=epsg:4326"))

crimes.df$GEO_LAT <- as.numeric(gsub(",", ".", gsub("\\.", "", crimes.df[["GEO_LAT"]])))
crimes.df$GEO_LONG <- as.numeric(gsub(",", ".", gsub("\\.", "", crimes.df[["GEO_LONG"]])))

crimes.df <- crimes.df[!is.na(crimes.df$GEO_LAT)&!is.na(crimes.df$GEO_LONG), ]

crimes <- crimes.df

coordinates(crimes) =~ GEO_LONG+GEO_LAT
projection(crimes) = projection(poland)


png(filename='../plot/swd_on_poland.png', width=2500, height=3000, res=300)
plot(poland, col = 'light blue')
points(crimes, col = 'red', cex=.5, pch='+')
dev.off()

#### Białystok
bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
bialystok <- aggregate(bialystok)

print(paste('Start time: ', Sys.time(), sep = ''))
crimesBialystok <- intersect(crimes, bialystok)
print(paste('End time: ', Sys.time(), sep = ''))

crimesBialystokDF <- data.frame(crimesBialystok)
write.csv(crimesBialystokDF, file = "../data/bialystok/swd/crimes_bialystok.csv")

#### Olsztyn
olsztyn <- shapefile("../data/additional/boundries/olsztyn/olsztyn.shp")
olsztyn <- spTransform(olsztyn, CRS("+init=epsg:4326"))
olsztyn <- aggregate(olsztyn)

print(paste('Start time: ', Sys.time(), sep = ''))
crimesOlsztyn <- intersect(crimes, olsztyn)
print(paste('End time: ', Sys.time(), sep = ''))

crimesOlsztynDF <- data.frame(crimesOlsztyn)
write.csv(crimesOlsztynDF, file = "../data/olsztyn/swd/crimes_olsztyn.csv")

count(crimesBialystokDF$GRUPA_KOD)
count(crimesOlsztynDF$GRUPA_KOD)
