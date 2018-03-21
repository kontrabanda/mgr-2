library(lubridate)
source(file="./data/DataBase.R")

BostonData <- setRefClass(
  Class="BostonData",
  fields=list(
    rawData="data.frame",
    categories="character",
    allColnames="character",
    propertiesColnames="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "boston"
      allColnames <<- c("lat", "lng", "day", "month", "category")
      propertiesColnames <<- c("lat", "lng", "day", "month")
    },
    extractData = function(params = NULL) {
      data <- readData()
      print(nrow(data))
      rawData <<- parseData(data)
    },
    readData = function() {
      read.csv(file = const$bostonDataPath)
    },
    parseData = function(inputData) {
      data <- setNames(data.frame(matrix(ncol = length(allColnames), nrow = nrow(inputData))), allColnames)
      #data$hour <- inputData$HOUR
      data$day <- inputData$DAY_OF_WEEK
      data$month <- inputData$MONTH
      data$year <- inputData$YEAR
      data$lat <- inputData$Lat
      data$lng <- inputData$Long
      data$category <- inputData$OFFENSE_CODE_GROUP
      data <- removeRareCategories(data)
      data$category <- gsub('/', '_', data$category)
      data$category <- factor(data$category)
      categories <<- as.character(unique(data$category))
      data
    },
    removeRareCategories = function(data) {
      rareCategories = c(
        'Motor Vehicle Accident Response', 'Larceny', 'Medical Assistance', 'Investigate Person', 'Other', 'Vandalism', 'Drug Violation', 'Simple Assault')
      data[data$category %in% rareCategories,]
    },
    getData = function(category) {
      data <- rawData[, propertiesColnames]
      data$label <- as.factor(ifelse(rawData$category==category, 1, 0))
      data
    },
    getTestData = function() {
      data <- rawData[, propertiesColnames]
      data
    },
    getClassificationCategories = function() {
      unique(rawData$category)
    }
  ),
  contains=c("DataBase")
)