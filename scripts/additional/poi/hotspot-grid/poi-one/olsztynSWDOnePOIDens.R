library(raster)
library(sp)
library(rgeos)

#categoryName <- 'CHU'
#r <- 200

## INIT
city <- shapefile("../data/additional/boundries/olsztyn/olsztyn.shp")
city <- spTransform(city, CRS("+init=epsg:4326"))
city <- aggregate(city)
crimesPath <- paste('../data/hotspot-grid/olsztynSWD/', categoryName, '.csv', sep = '')
crimes <- read.csv(crimesPath)
crimesDf <- crimes
coordinates(crimes) =~ x+y
projection(crimes) = "+proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0"
#projection(crimes) = projection(city)

poiShape <- shapefile("../data/additional/poi/olsztyn/gis.osm_pois_free_1.shp")

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

poiCity@data$fclass <- 'all'
categories <- unique(poiCity@data$fclass)

result <- computeDensity()
filePath <- paste("../data/hotspot-grid/olsztynSWD/poi-one/", r, "/", categoryName, "_poi_dens_", r, ".csv", sep = '')
write.csv(result, file = filePath)
