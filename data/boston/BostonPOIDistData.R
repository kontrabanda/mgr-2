library(lubridate)
library(dplyr)
source(file="./data/boston/BostonData.R")

BostonPOIDistData <- setRefClass(
  Class="BostonPOIDistData",
  fields=list(),
  methods = list(
    initialize = function() {
      name <<- "boston"
      allColnames <<- c(c("lat", "lng", "day", "month", "year", "category"), const$poiCategories)
      propertiesColnames <<- c(c("lat", "lng", "day", "month", "year"), const$poiCategories)
      extractData()
    },
    readData = function() {
      read.csv(file = const$bostonPOIPath)
    },
    parseData = function(inputData) {
      data <- callSuper(inputData)
      data[, const$poiCategories] <- inputData[, const$poiCategories]
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      summWithCategories <- data %>% group_by(lat, lng, day, month, year) %>% summarize(category = makeCategoryList(category))
      summWithPoi <- data %>% group_by(lat, lng, day, month, year) %>% summarize_at(const$poiCategories, mean)
      data <- summWithPoi
      data$category <- summWithCategories$category
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
  contains=c("BostonData")
)