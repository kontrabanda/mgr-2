library(raster)
library(sp)
library(rgeos)

#categoryName <- 'CHU'

## INIT
city <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)
crimesPath <- paste('../data/points-in-hotspots/bialystok/', categoryName, '.csv', sep = '')
crimes <- read.csv(crimesPath)
crimesDf <- crimes
coordinates(crimes) =~ lng+lat
projection(crimes) = projection(city)

poiShape <- shapefile("../data/additional/poi/bialystok/gis.osm_pois_free_1.shp")

source('./scripts/additional/poi/osmUtil.R')

## DENSITY
drawCircleAroundPoint <- function(point, radius) {
  point <- data.frame(lat = point['lat'], lng = point['lng'], name = 'circle')
  coordinates(point) =~ lng+lat
  crs(point) <- aeqdGlobal
  stopifnot(length(point) == 1)
  aeqd <- sprintf("+proj=aeqd +lat_0=0 +lon_0=0 +x_0=%s +y_0=%s",
                  point@coords[[2]], point@coords[[1]])
  projected <- spTransform(point, CRS(aeqd))
  buffered <- gBuffer(projected, width=radius, byid=TRUE)
  spTransform(buffered, point@proj4string)
}

pointsDensity <- data.frame(crimes)
pointsDensity <- pointsDensity[, c('lng', 'lat')]

result <- computeDensity()
filePath <- paste("../data/points-in-hotspots/bialystok/poi/", r, "/", categoryName, "_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)
