library(raster)
library(sp)

bournemouth <- shapefile("../data/dodatkowe/gb/boundries/Bournemouth.shp")
bournemouth <- spTransform(bournemouth, CRS("+init=epsg:4326"))

onlyBournemouth <- aggregate(bournemouth)

crime <- read.csv("../data/dodatkowe/gb/crimes/dorset/dorset-all.csv")
crime$Longitude <- as.numeric(levels(crime$Longitude))[crime$Longitude]
crime$Latitude <- as.numeric(levels(crime$Latitude))[crime$Latitude]
crime <- crime[!is.na(crime$Latitude)&!is.na(crime$Longitude), ]

coordinates(crime) =~ Longitude+Latitude
projection(crime) = projection(bournemouth)

crimeBournemouth <- intersect(crime, onlyBournemouth)
crimeBournemouthDF <- data.frame(crimeBournemouth)

write.csv(crimeBournemouthDF, file = "../data/dodatkowe/gb/crimes/crime_only_bournemouth_3.csv")
