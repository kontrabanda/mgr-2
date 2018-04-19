library(lubridate)
source(file="./data/DataBase.R")

BialystokHotspotPOIData <- setRefClass(
  Class="BialystokHotspotPOIData",
  fields=list(
    categories="character",
    allColnames="character",
    propertiesColnames="character",
    r="numeric"
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c(const$poiCategories ,c("label"))
      propertiesColnames <<- const$poiCategories
      r <<- 100
    },
    extractData = function(params = NULL) {
      categories <<- extractCategories()
    },
    readData = function() {
      read.csv(const$bialystokHotSpotPath, sep = ",")
    },
    extractCategories = function() {
      c('CHU')
    },
    getData = function(category) {
      categoryPath <- paste(const$bialystokHotSpotPath, 'poi', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data[, allColnames]
    },
    getTestData = function(category) {
      categoryPath <- paste(const$bialystokHotSpotPath, 'poi', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      date[, propertiesColnames]
    },
    getCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)