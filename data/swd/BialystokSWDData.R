library(lubridate)
source(file="./data/DataBase.R")

BialystokSWDData <- setRefClass(
  Class="BialystokSWDData",
  fields=list(
    rawData="data.frame",
    categories="character",
    allColnames="character",
    propertiesColnames="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystokSWD"
      allColnames <<- c("lat", "lng", "category")
      propertiesColnames <<- c("lat", "lng")
    },
    extractData = function(params = NULL) {
      data <- readData()
      categories <<- as.character(unique(data$GRUPA_KOD))
      rawData <<- parseData(data)
    },
    readData = function() {
      read.csv(const$bialystokSWDPath, sep = ",")
    },
    parseData = function(inputData) {
      data <- setNames(data.frame(matrix(ncol = length(allColnames), nrow = nrow(inputData))), allColnames)
      data$lat <- inputData$GEO_LAT
      data$lng <- inputData$GEO_LONG
      data$category <- inputData$GRUPA_KOD
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