library(lubridate)
library(dplyr)
source(file="./data/bournemouth/BournemouthData.R")

BournemouthPOIDistData <- setRefClass(
  Class="BournemouthPOIDistData",
  fields=list(),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      allColnames <<- c(c("lat", "lng", "month", "year", "category"), const$poiCategories)
      propertiesColnames <<- c(c("lat", "lng", "month", "year"), const$poiCategories)
      extractData()
    },
    readData = function() {
      read.csv(file = const$bournemouthPOIPath)
    },
    parseData = function(inputData) {
      data <- callSuper(inputData)
      data[, const$poiCategories] <- inputData[, const$poiCategories]
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(.dots=propertiesColnames) %>% summarize(category = makeCategoryList(category))
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