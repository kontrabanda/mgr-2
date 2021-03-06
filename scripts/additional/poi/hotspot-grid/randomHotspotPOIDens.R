library(raster)
library(sp)
library(rgeos)

r <- 200

## INIT bialystok
city <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)
cityName <- 'bialystok'
crimesPath <- paste('../data/hotspot-grid/random/', cityName, 'Random.csv', sep = '')
poiShape <- shapefile("../data/additional/poi/bialystok/gis.osm_pois_free_1.shp")

## INIT bournemouth
city <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)
cityName <- 'bournemouth'
crimesPath <- paste('../data/hotspot-grid/random/', cityName, 'Random.csv', sep = '')
poiShape <- shapefile("../data/additional/poi/bournemouth/gis.osm_pois_free_1.shp")





crimes <- read.csv(crimesPath)
crimesDf <- crimes
coordinates(crimes) =~ x+y
projection(crimes) = "+proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0"
#projection(crimes) = projection(city)



source('./scripts/additional/poi/osmUtil.R')

## DENSITY
drawCircleAroundPoint <- function(point, radius) {
  point <- data.frame(x = point['x'], y = point['y'], name = 'circle')
  coordinates(point) =~ x+y
  crs(point) <- aeqdGlobal
  stopifnot(length(point) == 1)
  aeqd <- sprintf("+proj=aeqd +lat_0=0 +lon_0=0 +x_0=%s +y_0=%s",
                  point@coords[[2]], point@coords[[1]])
  projected <- spTransform(point, CRS(aeqd))
  buffered <- gBuffer(projected, width=radius, byid=TRUE)
  spTransform(buffered, point@proj4string)
}

pointsDensity <- data.frame(crimes)
pointsDensity <- pointsDensity[, c('x', 'y')]

result <- computeDensity()
filePath <- paste("../data/hotspot-grid/random/poi/", r, "/", cityName, "Random_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)
