library(raster)
library(sp)
library(rgeos)

if(is.na(r)) {
  stop('r not set')
}

city <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)

crimes <- read.csv("../data/bournemouth/crimes_bournemouth.csv")
crimesDf <- crimes
coordinates(crimes) =~ Longitude+Latitude
projection(crimes) = projection(city)

poiShape <- shapefile("../data/additional/poi/bournemouth/gis.osm_pois_free_1.shp")

source('./scripts/additional/poi/osmUtil.R')

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

result <- computeDensity()
filePath <- paste("../data/bournemouth/bournemouth_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)

