library(lubridate)
library(dplyr)
source(file="./data/bialystok/BialystokData.R")

BialystokPopulationData <- setRefClass(
  Class="BialystokPopulationData",
  fields=list(),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c("lat", "lng", "day", "month", 'population', "category")
      propertiesColnames <<- c("lat", "lng", "day", "month", 'population')
    },
    readData = function() {
      read.csv(const$bialystokPopulation)
    },
    parseData = function(inputData) {
      inputData$DATA <- as.Date(inputData$DATA, "%y/%m/%d")
      data <- setNames(data.frame(matrix(ncol = length(allColnames), nrow = nrow(inputData))), allColnames)
      data$month <- as.factor(month(as.Date(inputData$DATA, "%y/%m/%d")))
      data$day <- as.factor(weekdays(as.Date(inputData$DATA, "%y/%m/%d")))
      data$year <- as.factor(year(as.Date(inputData$DATA, "%y/%m/%d")))
      data$lat <- inputData$LAT
      data$lng <- inputData$LNG
      data$category <- inputData$KAT
      data$population <- inputData$population
      
      data <- removeIncompeleteData(data)
      
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(lat, lng, day, month, year, population) %>% summarize(category = makeCategoryList(category))
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
  contains=c("BialystokData")
)