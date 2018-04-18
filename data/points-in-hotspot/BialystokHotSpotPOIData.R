library(lubridate)
source(file="./data/DataBase.R")

BialystokHotSpotPOIData <- setRefClass(
  Class="BialystokHotSpotPOIData",
  fields=list(
    rawData="data.frame",
    categories="character",
    allColnames="character",
    propertiesColnames="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c("lat", "lng", "label")
      propertiesColnames <<- c("lat", "lng")
    },
    extractData = function(params = NULL) {
      data <- readData()
      categories <<- as.character(unique(data$KAT))
      rawData <<- parseData(data)
    },
    readData = function() {
      read.csv(const$bialystokDataPath, sep = ",")
    },
    parseData = function(inputData) {
      data <- setNames(data.frame(matrix(ncol = length(allColnames), nrow = nrow(inputData))), allColnames)
      data$category <- inputData$KAT
      data
    },
    getData = function() {
      data <- rawData[, propertiesColnames]
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