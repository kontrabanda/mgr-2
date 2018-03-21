library(lubridate)
library(dplyr)
source(file="./data/bournemouth/BournemouthData.R")

BournemouthDataWithoutDuplicates <- setRefClass(
  Class="BournemouthDataWithoutDuplicates",
  fields=list(
    rawData="data.frame",
    categories="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      allColnames <<- c("lat", "lng", "month", "category")
      propertiesColnames <<- c("lat", "lng", "month")
    },
    parseData = function(inputData) {
      data <- callSuper(inputData)
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(lat, lng, month, year) %>% summarize(category = makeCategoryList(category))
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