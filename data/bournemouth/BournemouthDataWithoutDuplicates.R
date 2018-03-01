library(lubridate)
library(dplyr)
source(file="../data/DataBase.R")

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
      data <- setNames(data.frame(matrix(ncol = 5, nrow = nrow(bournemouthData))), c("lat", "lng", "month", "year", "category"))
      
      data$month <- as.factor(substring(bournemouthData$Date, 1, 4))
      data$year <- as.factor(substring(bournemouthData$Date, 6, 7))
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
      data <- rawData[, c("lat", "lng", "month", "year")]
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getTestData = function() {
      data <- rawData[, c("lat", "lng", "month", "year")]
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)