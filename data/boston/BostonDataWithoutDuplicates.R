library(lubridate)
library(dplyr)
source(file="../data/DataBase.R")

BostonDataWithoutDuplicates <- setRefClass(
  Class="BostonDataWithoutDuplicates",
  fields=list(
    rawData="data.frame",
    categories="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "boston"
      bostonData <- read.csv(file = const$bostonDataPath)
      data <- setNames(data.frame(matrix(ncol = 7, nrow = nrow(bostonData))), c("lat", "lng", "hour", "day", "month", "year", "category"))
      
      data$hour <- bostonData$HOUR
      data$day <- bostonData$DAY_OF_WEEK
      data$month <- bostonData$MONTH
      data$year <- bostonData$YEAR
      data$lat <- bostonData$Lat
      data$lng <- bostonData$Long
      data$category <- bostonData$OFFENSE_CODE_GROUP
      data <- removeRareCategories(data)
      data$category <- gsub('/', '_', data$category)
      data$category <- factor(data$category)
      categories <<- as.character(unique(data$category))
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(lat, lng, hour, day, month, year) %>% summarize(category = makeCategoryList(category))
      rawData <<- data
    },
    removeRareCategories = function(data) {
      rareCategories = c(
        'Motor Vehicle Accident Response', 'Larceny', 'Medical Assistance', 'Investigate Person', 'Other', 'Vandalism', 'Drug Violation', 'Simple Assault')
      data[data$category %in% rareCategories,]
    },
    getData = function(category) {
      data <- rawData[, c("lat", "lng", "hour", "day", "month", "year")]
      #data$label <- as.factor(ifelse(rawData$category==category, 1, 0))
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getTestData = function() {
      data <- rawData[, c("lat", "lng", "hour", "day", "month", "year")]
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)