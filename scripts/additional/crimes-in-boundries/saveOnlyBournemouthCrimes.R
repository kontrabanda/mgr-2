library(raster)
library(sp)

print('Computing crimes in Bournemouth...')
print(paste('Start at:', Sys.time(), sep = ' '))

bournemouth <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
bournemouth <- spTransform(bournemouth, CRS("+init=epsg:4326"))

onlyBournemouth <- aggregate(bournemouth)

crime <- read.csv("../data/additional/crimes/crimes-dorset.csv")
crime$Longitude <- as.numeric(levels(crime$Longitude))[crime$Longitude]
crime$Latitude <- as.numeric(levels(crime$Latitude))[crime$Latitude]
crime <- crime[!is.na(crime$Latitude)&!is.na(crime$Longitude), ]

coordinates(crime) =~ Longitude+Latitude
projection(crime) = projection(bournemouth)

crimeBournemouth <- intersect(crime, onlyBournemouth)
crimeBournemouthDF <- data.frame(crimeBournemouth)

write.csv(crimeBournemouthDF, file = "../data/bournemouth/crimes_bournemouth.csv")

print(paste('Finish at:', Sys.time(), sep = ' '))
print('Finish computing.')
