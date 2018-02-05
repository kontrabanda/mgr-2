library(lubridate)
library(dplyr)
source(file="./data/DataBase.R")

BialystokDataWithoutDuplicates <- setRefClass(
  Class="BialystokDataWithoutDuplicates",
  fields=list(
    rawData="data.frame",
    categories="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      crimeBialystokDF <- read.csv(const$bialystokDataPath, sep = ",")
      crimeBialystokDF$DATA <- as.Date(crimeBialystokDF$DATA, "%y/%m/%d")
      
      data <- setNames(data.frame(matrix(ncol = 6, nrow = nrow(crimeBialystokDF))), c("lat", "lng", "day", "month", "year", "category"))
      data$month <- as.factor(month(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$day <- as.factor(day(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$year <- as.factor(year(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$lat <- crimeBialystokDF$LAT
      data$lng <- crimeBialystokDF$LNG
      data$category <- crimeBialystokDF$KAT
      categories <<- as.character(unique(crimeBialystokDF$KAT))
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      data <- data %>% group_by(lat, lng, day, month, year) %>% summarize(category = makeCategoryList(category))
      rawData <<- data
    },
    getData = function(category) {
      data <- rawData[, c("lat", "lng", "day", "month", "year")]
      #data$label <- as.factor(ifelse(rawData$category==category, 1, 0))
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getTestData = function() {
      data <- rawData[, c("lat", "lng", "day", "month", "year")]
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)