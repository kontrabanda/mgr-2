library(raster)
library(sp)
library(rgeos)

r <- 100

## INIT bialystok
city <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)
crimesPath <- '../data/points-in-hotspots/random/bialystokRandom.csv'
crimes <- read.csv(crimesPath)
crimesDf <- crimes
coordinates(crimes) =~ lng+lat
projection(crimes) = projection(city)
cityName <- 'bialystok'

poiShape <- shapefile("../data/additional/poi/bialystok/gis.osm_pois_free_1.shp")

## INIT bournemouth
city <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)
crimesPath <- '../data/points-in-hotspots/random/bournemouthRandom.csv'
crimes <- read.csv(crimesPath)
crimesDf <- crimes
coordinates(crimes) =~ lng+lat
projection(crimes) = projection(city)
cityName <- 'bournemouth'

poiShape <- shapefile("../data/additional/poi/bournemouth/gis.osm_pois_free_1.shp")



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
filePath <- paste("../data/points-in-hotspots/random/poi/", r, "/", cityName, "Random_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)
