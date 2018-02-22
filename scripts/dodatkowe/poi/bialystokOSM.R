library(raster)
library(sp)
library(rgeos)

## INIT
city <- shapefile("../data/dodatkowe/bialystok/bialystok.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)
crimes <- read.csv("../data/dodatkowe/Polska/zdarzenia_rsow_bialystok.csv")
coordinates(crimes) =~ LNG+LAT
projection(crimes) = projection(city)

poiShape <- shapefile("../data/dodatkowe/poi/osm/podlaskie/podlaskie-latest-free.shp/gis.osm_pois_free_1.shp")
churchesShape <- shapefile("../data/dodatkowe/poi/osm/podlaskie/podlaskie-latest-free.shp/gis.osm_pofw_free_1.shp")

source('./scripts/dodatkowe/poi/osmUtil.R')

## DISTANCE
result <- computeDistance()
write.csv(result, file = "../data/results/bialystok_poi_dist.csv")

## DENSITY
drawCircleAroundPoint <- function(point, radius) {
  point <- data.frame(LAT = point['LAT'], LNG = point['LNG'], name = 'circle')
  coordinates(point) =~ LNG+LAT
  crs(point) <- aeqdGlobal
  stopifnot(length(point) == 1)
  aeqd <- sprintf("+proj=aeqd +lat_0=0 +lon_0=0 +x_0=%s +y_0=%s",
                  point@coords[[2]], point@coords[[1]])
  projected <- spTransform(point, CRS(aeqd))
  buffered <- gBuffer(projected, width=radius, byid=TRUE)
  spTransform(buffered, point@proj4string)
}

pointsDensity <- data.frame(crimes)
pointsDensity <- pointsDensity[, c('LNG', 'LAT')]

rm(result)
r <- 100
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/bialystok_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)

rm(result)
r <- 200
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/bialystok_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)

rm(result)
r <- 500
result <- computeDensity()
filePath <- paste("../data/dodatkowe/results/bialystok_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)
