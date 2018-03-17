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

result <- computeDensity()
filePath <- paste("../data/bialystok/bialystok_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)
