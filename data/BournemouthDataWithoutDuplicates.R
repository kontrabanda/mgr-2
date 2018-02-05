library(lubridate)
library(dplyr)
source(file="./data/DataBase.R")

BournemouthDataWithoutDuplicates <- setRefClass(
  Class="BournemouthDataWithoutDuplicates",
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
      categories <<- as.character(unique(data$category))
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(lat, lng, month) %>% summarize(category = makeCategoryList(category))
      rawData <<- data
    },
    getData = function(category) {
      data <- rawData[, c("lat", "lng", "month")]
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getTestData = function() {
      data <- rawData[, c("lat", "lng", "month")]
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)