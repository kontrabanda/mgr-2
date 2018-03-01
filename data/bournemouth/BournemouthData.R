library(lubridate)
source(file="./data/DataBase.R")

BournemouthData <- setRefClass(
  Class="BournemouthData",
  fields=list(
    rawData="data.frame",
    categories="character",
    allColnames="character",
    propertiesColnames="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      allColnames <<- c("lat", "lng", "month", "year", "category")
      propertiesColnames <<- c("lat", "lng", "month", "year")
      extractData()
    },
    extractData = function() {
      data <- readData()
      categories <<- as.character(unique(data$Crime.type))
      rawData <<- parseData(data)
    },
    readData = function() {
      read.csv(file = const$bournemouthDataPath)
    },
    parseData = function(inputData) {
      inputData$Date <- inputData$Month
      data <- setNames(data.frame(matrix(ncol = length(allColnames), nrow = nrow(inputData))), allColnames)
      data$year <- as.factor(substring(inputData$Date, 1, 4))
      data$month <- as.factor(substring(inputData$Date, 6, 7))
      data$lat <- inputData$Latitude
      data$lng <- inputData$Longitude
      data$category <- inputData$Crime.type
      data
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