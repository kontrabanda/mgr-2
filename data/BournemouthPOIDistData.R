library(lubridate)
library(dplyr)
source(file="./data/DataBase.R")

BournemouthPOIDistData <- setRefClass(
  Class="BournemouthPOIDistData",
  fields=list(
    rawData="data.frame",
    categories="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      bournemouthData <- read.csv(file = const$bournemouthDataPath)
      data <- setNames(data.frame(matrix(ncol = 4, nrow = nrow(bournemouthData))), c("lat", "lng", "month", "category"))
      
      data$month <- bournemouthData$Month
      data$lat <- bournemouthData$Latitude
      data$lng <- bournemouthData$Longitude
      data$category <- bournemouthData$Crime.type
      
      distPOI <- read.csv(const$bournemouthPOIPath)
      distPOI <- distPOI[, const$poiCategories]
      data[const$poiCategories] <- distPOI
      
      categories <<- as.character(unique(data$category))
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      groups <- c(c('lat', 'lng', 'month'), const$poiCategories)
      data <- data %>% group_by(.dots=groups) %>% summarize(category = makeCategoryList(category))
      rawData <<- data
    },
    getData = function(category) {
      columns <-  c(c("lat", "lng", "month"), const$poiCategories)
      data <- rawData[, columns]
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getTestData = function() {
      columns <-  c(c("lat", "lng", "month"), const$poiCategories)
      data <- rawData[, columns]
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)