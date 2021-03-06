library(lubridate)
source(file="./data/DataBase.R")

BialystokData <- setRefClass(
  Class="BialystokData",
  fields=list(
    rawData="data.frame",
    categories="character",
    allColnames="character",
    propertiesColnames="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c("lat", "lng", "day", "month", "category")
      propertiesColnames <<- c("lat", "lng", "day", "month")
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
      inputData$DATA <- as.Date(inputData$DATA, "%y/%m/%d")
      data <- setNames(data.frame(matrix(ncol = length(allColnames), nrow = nrow(inputData))), allColnames)
      data$month <- as.factor(month(as.Date(inputData$DATA, "%y/%m/%d")))
      data$day <- as.factor(weekdays(as.Date(inputData$DATA, "%y/%m/%d")))
      data$year <- as.factor(year(as.Date(inputData$DATA, "%y/%m/%d")))
      data$lat <- inputData$LAT
      data$lng <- inputData$LNG
      data$category <- inputData$KAT
      
      data <- removeIncompeleteData(data)
      data
    },
    removeIncompeleteData = function(data) {
      years <- as.numeric(as.character(data$year))
      months <- as.numeric(as.character(data$month))
      data[years >= 2009 & !(years == 2016 & months == 12) & !(years == 2016 & months == 11), ]
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