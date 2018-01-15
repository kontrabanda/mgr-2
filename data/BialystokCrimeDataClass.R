library(lubridate)
source(file="./data/DataClass.R")

BialystokCrimeDataClass <- setRefClass(
  Class="BialystokDataClass",
  fields=list(
    rawData="data.frame"
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      crimeBialystokDF <- read.csv("../data/Polska/zdarzenia_rsow_bialystok.csv", sep = ",")
      crimeBialystokDF$DATA <- as.Date(crimeBialystokDF$DATA, "%y/%m/%d")
      
      data <- setNames(data.frame(matrix(ncol = 6, nrow = nrow(crimeBialystokDF))), c("lat", "lng", "day", "month", "year", "category"))
      data$month <- as.factor(month(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$day <- as.factor(day(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$year <- as.factor(year(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$lat <- crimeBialystokDF$LAT
      data$lng <- crimeBialystokDF$LNG
      data$category <- crimeBialystokDF$KAT
      rawData <<- data
    },
    getData = function(category) {
      data <- rawData[, c("lat", "lng", "day", "month", "year")]
      data$label <- as.factor(ifelse(rawData$category==category, 1, 0))
      data
    },
    getTestData = function() {
      data <- rawData[, c("lat", "lng", "day", "month", "year")]
      data
    },
    getClassificationCategories = function() {
      unique(rawData$category)
    }
  ),
  contains=c("DataClass")
)