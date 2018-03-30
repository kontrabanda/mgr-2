library(lubridate)
library(dplyr)
source(file="./data/bialystok/BialystokData.R")

BialystokWeatherData <- setRefClass(
  Class="BialystokWeatherData",
  fields=list(),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c("lat", "lng", "day", "month", 'tempDay', 'tempNight', 'weatherDay', 'weatherNight', "category")
      propertiesColnames <<- c("lat", "lng", "day", "month", 'tempDay', 'tempNight', 'weatherDay', 'weatherNight')
    },
    readData = function() {
      read.csv(const$bialystokWeather)
    },
    parseData = function(inputData) {
      data <- callSuper(inputData)
      inputWithWeather <- removeIncompeleteData(inputData)
      data$tempDay <- inputWithWeather$tempDay
      data$tempNight <- inputWithWeather$tempNight
      data$weatherDay <- inputWithWeather$weatherDay
      data$weatherNight <- inputWithWeather$weatherNight
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(lat, lng, day, month, year, tempDay, tempNight, weatherDay, weatherNight) %>% summarize(category = makeCategoryList(category))
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