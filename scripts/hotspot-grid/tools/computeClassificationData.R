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
crimeCategoryName <- 'CHU'
numOfRandomPoints <- 10000
hotspotRatio <- 0.05
ds.size <- 0.1
cellSize <- 10 # in meters
oneLabelRatio <- 0.5
zeroLabelRatio <- 0.5
#### extract data
bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
city <- aggregate(bialystok)

crimesData <- BialystokDataWithoutDuplicates()
crimesData$extractData()


print(paste('Computing hotspots grid for', crimesData$name , 'for category: ', crimeCategoryName, sep = ' '))

categories <- crimesData$categories

categoryData <- crimesData$getData(crimeCategoryName)
onlyCategoryData <- categoryData[categoryData$label == 1, ][1:2]

coordinates(onlyCategoryData) =~ lng+lat
projection(onlyCategoryData) = projection(city)
aeqdGlobal <- "+proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0"

onlyCategoryData <- spTransform(onlyCategoryData, aeqdGlobal)
city <- spTransform(city, aeqdGlobal)

#### kde
cityOwin <- as.owin(city)
pts <- coordinates(onlyCategoryData)
p <- ppp(pts[,1], pts[,2], window = cityOwin)

dens <- density(p, adjust = ds.size, kernel="gaussian", window = kernel)

plot(dens)
plot(city, add=T)

createKDERasterMask <- function(dens, city) {
  rt <- raster(dens)
  crs(rt) <- crs(city)
  
  rcity <- raster(city)
  res(rcity) <- cellSize
  
  r <- resample(rt, rcity)
  
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
hotspotOverlay
plot(hotspotOverlay)

s <- sampleRandom(hotspotOverlay, length(values(hotspotOverlay)), cells=T, xy=T)
s <- data.frame(s)
data <- data.frame(x = s$x, y = s$y, label = s$layer)
label.1 <- data[data$label == 1, ]
label.0 <- data[data$label == 0, ]

count.1 <- oneLabelRatio * nrow(label.1)
count.0 <- zeroLabelRatio * nrow(label.1)


label.1.results <- label.1[sample(nrow(label.1), count.1), ]
label.0.results <- label.0[sample(nrow(label.0), count.0), ]

result <- rbind(label.1.results, label.0.results)

randomizeResults <- result[sample(nrow(result)), ]
  
resultPath <- paste('../data/cells-in-hotspots', crimesData$name, crimeCategoryName, sep = '/')
resultPath <- paste(resultPath, '.csv', sep = '')
write.csv(x = randomizeResults, file = resultPath)

#length(values(hotspotOverlay))
#xyFromCell(hotspotOverlay, 1234)


