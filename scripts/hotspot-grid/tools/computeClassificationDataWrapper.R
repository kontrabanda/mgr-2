library(methods) # for Rscript

library(raster)
library(sp)
library(latticeExtra)
library(RColorBrewer)
library(ggplot2)
library(maptools)
library(spatstat)
library(rgdal)

args = commandArgs(trailingOnly=TRUE)

source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
source(file="./data/bournemouth/BournemouthDataWithoutDuplicates.R")
source(file = './data/swd/BialystokSWDData.R')
source(file = './data/swd/OlsztynSWDData.R')
source(file="./const.R")

cityName <- args[1]
cellSize <- as.numeric(args[2])

if(cityName == 'bialystok') {
  crimesData <- BialystokDataWithoutDuplicates()
  crimesData$extractData()
  
  categories <- crimesData$categories
  
  bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
  bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
  city <- aggregate(bialystok)
} else if(cityName == 'bournemouth') {
  crimesData <- BournemouthDataWithoutDuplicates()
  crimesData$extractData()
  
  categories <- crimesData$categories
  
  bournemouth <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
  bournemouth <- spTransform(bournemouth, CRS("+init=epsg:4326"))
  city <- aggregate(bournemouth)
} else if(cityName == 'bialystokSWD') {
  crimesData <- BialystokSWDData()
  crimesData$extractData()
  
  categories <- crimesData$categories
  
  bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
  bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
  city <- aggregate(bialystok)
} else if(cityName == 'olsztynSWD') {
  crimesData <- OlsztynSWDData()
  crimesData$extractData()
  
  categories <- crimesData$categories
  
  olsztyn <- shapefile("../data/additional/boundries/olsztyn/olsztyn.shp")
  olsztyn <- spTransform(olsztyn, CRS("+init=epsg:4326"))
  city <- aggregate(olsztyn)
}

for(singleCategory in categories) {
  tryCatch(
    {
      crimeCategoryName <<- singleCategory
      source(file = './scripts/hotspot-grid/tools/computeClassificationData2.R')
    },
    error = function(cond) {
      print(paste('ERROR in ', singleCategory, sep = ''))
      print(cond)
    }
  )
}




