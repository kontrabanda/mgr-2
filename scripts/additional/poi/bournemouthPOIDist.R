library(raster)
library(sp)
library(rgeos)

city <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)

crimes <- read.csv("../data/bournemouth/crimes_bournemouth.csv")
crimesDf <- crimes
coordinates(crimes) =~ Longitude+Latitude
projection(crimes) = projection(city)

poiShape <- shapefile("../data/additional/poi/bournemouth/gis.osm_pois_free_1.shp")

source('./scripts/additional/poi/osmUtil.R')

result <- computeDistance()
result <- result[, categories]
result <- cbind(crimesDf, result)
write.csv(result, file = "../data/bournemouth/bournemouth_poi_dist.csv")
