library(raster)
library(sp)
library(rgeos)

city <- shapefile("../data/dodatkowe/gb/boundries/Bournemouth.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)

crimes <- read.csv("../data/dodatkowe/gb/crimes/crime_only_bournemouth.csv")
crimesDf <- crimes
coordinates(crimes) =~ Longitude+Latitude
projection(crimes) = projection(city)

poiShape <- shapefile("../data/dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_pois_free_1.shp")
churchesShape <- shapefile("../data/dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_pofw_free_1.shp")

source('./scripts/dodatkowe/poi/osmUtil.R')

## DISTANCE
result <- computeDistance()
result <- result[, categories]
result <- cbind(crimesDf, result)
write.csv(result, file = "../data/dodatkowe/results/bournemouth_poi_dist.csv")

## DENSITY
drawCircleAroundPoint <- function(point, radius) {
  point <- data.frame(Latitude = point['Latitude'], Longitude = point['Longitude'], name = 'circle')
  coordinates(point) =~ Longitude+Latitude
  crs(point) <- aeqdGlobal
  stopifnot(length(point) == 1)
  aeqd <- sprintf("+proj=aeqd +lat_0=0 +lon_0=0 +x_0=%s +y_0=%s",
                  point@coords[[2]], point@coords[[1]])
  projected <- spTransform(point, CRS(aeqd))
  buffered <- gBuffer(projected, width=radius, byid=TRUE)
  spTransform(buffered, point@proj4string)
}

pointsDensity <- data.frame(crimes)
pointsDensity <- pointsDensity[, c('Longitude', 'Latitude')]

rm(result)
r <- 100
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/bournemouth_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)

rm(result)
r <- 200
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/bournemouth_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)

rm(result)
r <- 500
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/bournemouth_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)

