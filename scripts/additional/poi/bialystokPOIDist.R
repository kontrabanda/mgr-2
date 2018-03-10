library(raster)
library(sp)
library(rgeos)

## INIT
city <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)
crimes <- read.csv("../data/bialystok/crimes_bialystok.csv")
crimesDf <- crimes
coordinates(crimes) =~ LNG+LAT
projection(crimes) = projection(city)

poiShape <- shapefile("../data/additional/poi/bialystok/gis.osm_pois_free_1.shp")

source('./scripts/additional/poi/osmUtil.R')


result <- computeDistance()
result <- result[, categories]
result <- cbind(crimesDf, result)
write.csv(result, file = "../data/bialystok/bialystok_poi_dist.csv")
