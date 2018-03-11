library(lubridate)
library(dplyr)
source(file="./data/boston/BostonData.R")

BostonDataWithoutDuplicates <- setRefClass(
  Class="BostonDataWithoutDuplicates",
  fields=list(),
  methods = list(
    initialize = function() {
      name <<- "boston"
      allColnames <<- c("lat", "lng", "day", "month", "category")
      propertiesColnames <<- c("lat", "lng", "day", "month")
      extractData()
    },
    parseData = function(inputData) {
      data <- callSuper(inputData)
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(lat, lng, day, month, year) %>% summarize(category = makeCategoryList(category))
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