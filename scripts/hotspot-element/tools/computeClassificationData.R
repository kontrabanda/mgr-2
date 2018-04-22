library(raster)
library(sp)
library(latticeExtra)
library(RColorBrewer)
library(ggplot2)
library(maptools)
library(spatstat)
library(rgdal)
library(spatialEco)
library(dismo)

source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
source(file="./const.R")

#### variables
#crimeCategoryName <- 'CHU'
#numOfRandomPoints <- 10000

#### extract data
#bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
#bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
#city <- aggregate(bialystok)

#crimesData <- BialystokDataWithoutDuplicates()
#crimesData$extractData()

print(paste('Computing hotspots data for', crimesData$name , 'for category: ', crimeCategoryName, sep = ' '))

categories <- crimesData$categories

categoryData <- crimesData$getData(crimeCategoryName)
onlyCategoryData <- categoryData[categoryData$label == 1, ][1:2]

coordinates(onlyCategoryData) =~ lng+lat
projection(onlyCategoryData) = projection(city)

#### kde
cityOwin <- as.owin(city)
pts <- coordinates(onlyCategoryData)
p <- ppp(pts[,1], pts[,2], window = cityOwin)

dens <- density(p, adjust = 0.1, kernel="gaussian", window = kernel)

plot(dens)
plot(city, add=T)

createKDERasterMask <- function(dens, city) {
  r <- raster(dens)
  crs(r) <- crs(city)
  hotspotRatio <- 0.05
  
  valuesTemp <- r@data@values
  valuesTemp <- valuesTemp[!is.na(valuesTemp)]
  
  sortValues <- sort.int(valuesTemp)
  nr <- length(sortValues)
  i <- round((1 - hotspotRatio) * length(sortValues))
  val <- sortValues[i]
  r@data@values <- ifelse(r@data@values > val, 1, 0)
  
  r
}

hotspotOverlay <- createKDERasterMask(dens, city)

#### generate random other points
set.seed(123)

outsideHotspotMask <- raster.invert(hotspotOverlay)
outsideHotspotMask@data@values[outsideHotspotMask@data@values == 0] <- NA

ranPoints <- randomPoints(outsideHotspotMask, numOfRandomPoints)
ranPointsOutsideHotspot <- data.frame(lng = ranPoints[,1], lat = ranPoints[,2])
coordinates(ranPointsOutsideHotspot) =~ lng+lat

#### Category data for hotspot
getCrimesFromHotspot <- function(hotspot, crimesPoints) {
  inn <- crimesPoints
  coordinates(inn) =~ lng+lat
  inn <- extract(hotspot, inn)
  inn <- inn[!is.na(inn)]
  crimesPoints[inn == 1, ]
}

crimesFromHotspot <- getCrimesFromHotspot(hotspotOverlay, categoryData[categoryData$label == 1, ])

label1Pts <- data.frame(crimesFromHotspot[, c('lat', 'lng')], label = 1)
label0Pts <- data.frame(ranPointsOutsideHotspot, label = 0)

results <- rbind(label0Pts, label1Pts)
results$lat <- round(results$lat, digits = 4)
results$lng <- round(results$lng, digits = 4)
randomizeResults <- results[sample(nrow(results)),]

resultPath <- paste('../data/points-in-hotspots', crimesData$name, crimeCategoryName, sep = '/')
resultPath <- paste(resultPath, '.csv', sep = '')
write.csv(x = randomizeResults, file = resultPath)

### powinno byc 0 elementow
#test <- getCrimesFromHotspot(hotspotOverlay, data.frame(ranPointsOutsidHotspot))

#Raster to matrix
r_matrix<-as.matrix(hotspotOverlay)
# ile procent to hotspoty
P0<-length(which(r_matrix==0))/(length(r_matrix)-length(which(is.na(r_matrix))))
P1<-length(which(r_matrix==1))/(length(r_matrix)-length(which(is.na(r_matrix))))
