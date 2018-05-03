library(lubridate)
source(file="./data/DataBase.R")

BialystokOlsztynSWDData <- setRefClass(
  Class="BialystokOlsztynSWDData",
  fields=list(
    categories="character",
    allColnames="character",
    propertiesColnames="character",
    r="numeric",
    trainCityName='character',
    testCityName='character'
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystokOlsztynSWD"
      allColnames <<- c(const$poiCategories ,c("label"))
      propertiesColnames <<- const$poiCategories
      r <<- 200
    },
    extractData = function(params = NULL, reverse = F) {
      if(reverse) {
        name <<- 'trainOlsztynTestBialystok'
        trainCityName <<- 'olsztyn'
        testCityName <<- 'bialystok'
      } else {
        name <<- 'trainBialystokTestOlsztyn'
        trainCityName <<- 'bialystok'
        testCityName <<- 'olsztyn'
      }
      categories <<- extractCategories()
    },
    readData = function() {
      read.csv(const$bialystokSWDGridHotSpotPath, sep = ",")
    },
    extractCategories = function() {
      c('BOJ', 'CHU', 'FIN', 'INN', 'INT', 'KOM', 'KRA', 'KRY', 'ROZ', 'ZAT', 'ZGO')
    },
    getData = function(cityName, category) {
      cityFilePath <- getCityFilePath(cityName)
      categoryPath <- paste(cityFilePath, 'poi', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data$label <- factor(data$label)
      data[, allColnames]
    },
    getTestData = function(category) {
      cityFilePath <- getCityFilePath(testCityName)
      categoryPath <- paste(cityFilePath, 'poi', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data[, propertiesColnames]
    },
    getCityFilePath = function(cityName) {
      if(cityName == 'bialystok') {
        filePath <- const$bialystokSWDGridHotSpotPath
      } else if(cityName == 'olsztyn') {
        filePath <- const$olsztynSWDGridHotSpotPath
      }
      filePath
    },
    getCategories = function() {
      categories
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)