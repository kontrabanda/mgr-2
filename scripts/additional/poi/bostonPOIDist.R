library(raster)
library(sp)
library(rgeos)

city <- shapefile("../data/additional/boundries/boston/Bos_neighborhoods.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)

crimes <- read.csv("../data/boston/crimes_boston.csv")
crimesDf <- crimes
coordinates(crimes) =~ Long+Lat
projection(crimes) = projection(city)

poiShape <- shapefile("../data/additional/poi/boston/gis.osm_pois_free_1.shp")

source('./scripts/additional/poi/osmUtil.R')

result <- computeDistance()
result <- result[, categories]
result <- cbind(crimesDf, result)
write.csv(result, file = "../data/boston/boston_poi_dist.csv")
