library(lubridate)
source(file="./data/DataClass.R")

BournemouthCrimeDataClass <- setRefClass(
  Class="BournemouthCrimeDataClass",
  fields=list(
    rawData="data.frame"
  ),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      bournemouthData <- read.csv(file = "../data/gb/crimes/crime_only_bournemouth.csv")
      data <- setNames(data.frame(matrix(ncol = 4, nrow = nrow(bournemouthData))), c("lat", "lng", "month", "category"))
      
      data$month <- bournemouthData$Month
      data$lat <- bournemouthData$Latitude
      data$lng <- bournemouthData$Longitude
      data$category <- bournemouthData$Crime.type
      rawData <<- data
    },
    getData = function(category) {
      data <- rawData[, c("lat", "lng", "month")]
      data$label <- as.factor(ifelse(rawData$category==category, 1, 0))
      data
    },
    getTestData = function() {
      data <- rawData[, c("lat", "lng", "month")]
      data
    },
    getClassificationCategories = function() {
      unique(rawData$category)
    }
  ),
  contains=c("DataClass")
)