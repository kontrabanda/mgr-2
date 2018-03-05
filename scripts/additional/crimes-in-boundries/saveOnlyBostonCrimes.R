library(raster)
library(sp)

print('Computing crimes in Boston...')
print(paste('Start at:', Sys.time(), sep = ' '))

boston <- shapefile("../data/additional/boundries/boston/Bos_neighborhoods.shp")
boston <- spTransform(boston, CRS("+init=epsg:4326"))
onlyBoston <- aggregate(boston)

crime <- read.csv("../data/additional/crimes/crimes-boston.csv")
crime <- crime[!is.na(crime$Lat)&!is.na(crime$Long), ]
coordinates(crime) =~ Long+Lat
projection(crime) = projection(boston)

crimeBoston <- intersect(crime, onlyBoston)
crimeBostonDF <- data.frame(crimeBoston)
write.csv(crimeBostonDF, file = "../data/boston/crimes_boston.csv")

print(paste('Finish at:', Sys.time(), sep = ' '))
print('Finish computing.')