library(lubridate)
library(dplyr)
source(file="./data/bournemouth/BournemouthData.R")

BournemouthPopulationData <- setRefClass(
  Class="BournemouthPopulationData",
  fields=list(),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      allColnames <<- c("lat", "lng", "month", "population","category")
      propertiesColnames <<- c("lat", "lng", "month", "population")
    },
    readData = function() {
      read.csv(file = const$bournemouthPopuplation)
    },
    parseData = function(inputData) {
      data <- callSuper(inputData)
      data$population <- inputData$population
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(lat, lng, month, year, population) %>% summarize(category = makeCategoryList(category))
      data
    },
    getData = function(category) {
      data <- rawData[, propertiesColnames]
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("BournemouthData")
)