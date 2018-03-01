library(lubridate)
source(file="../data/DataBase.R")

BournemouthData <- setRefClass(
  Class="BournemouthData",
  fields=list(
    rawData="data.frame"
  ),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      bournemouthData <- read.csv(file = const$bournemouthDataPath)
      data <- setNames(data.frame(matrix(ncol = 5, nrow = nrow(bournemouthData))), c("lat", "lng", "month", "year", "category"))
      
      data$month <- as.factor(substring(bournemouthData$Date, 1, 4))
      data$year <- as.factor(substring(bournemouthData$Date, 6, 7))
      data$lat <- bournemouthData$Latitude
      data$lng <- bournemouthData$Longitude
      data$category <- bournemouthData$Crime.type
      rawData <<- data
    },
    getData = function(category) {
      data <- rawData[, c("lat", "lng", "month", "year")]
      data$label <- as.factor(ifelse(rawData$category==category, 1, 0))
      data
    },
    getTestData = function() {
      data <- rawData[, c("lat", "lng", "month", "year")]
      data
    },
    getClassificationCategories = function() {
      unique(rawData$category)
    }
  ),
  contains=c("DataBase")
)