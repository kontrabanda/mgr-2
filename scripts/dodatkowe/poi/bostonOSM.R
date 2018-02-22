library(raster)
library(sp)
library(rgeos)

city <- shapefile("../data/dodatkowe/usa/boundries/boston/Bos_neighborhoods.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)

crimes <- read.csv("../data/dodatkowe/usa/crimes/crime_only_boston.csv")
coordinates(crimes) =~ Long+Lat
projection(crimes) = projection(city)

poiShape <- shapefile("../data/dodatkowe/poi/osm/massachusetts/massachusetts-latest-free.shp/gis.osm_pois_free_1.shp")
churchesShape <- shapefile("../data/dodatkowe/poi/osm/massachusetts/massachusetts-latest-free.shp/gis.osm_pofw_free_1.shp")

source('./scripts/dodatkowe/poi/osmUtil.R')

## DISTANCE
result <- computeDistance()
write.csv(result, file = "../data/results/boston_poi_dist.csv")

## DENSITY
drawCircleAroundPoint <- function(point, radius) {
  point <- data.frame(Lat = point['Lat'], Long = point['Long'], name = 'circle')
  coordinates(point) =~ Long+Lat
  crs(point) <- aeqdGlobal
  stopifnot(length(point) == 1)
  aeqd <- sprintf("+proj=aeqd +lat_0=0 +lon_0=0 +x_0=%s +y_0=%s",
                  point@coords[[2]], point@coords[[1]])
  projected <- spTransform(point, CRS(aeqd))
  buffered <- gBuffer(projected, width=radius, byid=TRUE)
  spTransform(buffered, point@proj4string)
}

pointsDensity <- data.frame(crimes)
pointsDensity <- pointsDensity[, c('Long', 'Lat')]

rm(result)
r <- 100
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/boston_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)

rm(result)
r <- 200
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/boston_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)

rm(result)
r <- 500
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/boston_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)
