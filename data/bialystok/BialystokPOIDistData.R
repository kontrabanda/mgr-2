library(lubridate)
library(dplyr)
source(file="./data/bialystok/BialystokData.R")

BialystokPOIDistData <- setRefClass(
  Class="BialystokPOIDistData",
  fields=list(),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c(c("lat", "lng", "day", "month", "year", "category"), const$poiCategories)
      propertiesColnames <<- c(c("lat", "lng", "day", "month", "year"), const$poiCategories)
      extractData()
    },
    readData = function() {
      read.csv(const$bialystokPOIPath)
    },
    parseData = function(inputData) {
      data <- callSuper(inputData)
      data[, const$poiCategories] <- inputData[, const$poiCategories]
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(.dots=propertiesColnames) %>% summarize(category = makeCategoryList(category))
      rawData <<- data
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
  contains=c("BialystokData")
)