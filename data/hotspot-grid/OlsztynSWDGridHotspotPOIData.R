library(lubridate)
source(file="./data/DataBase.R")

OlsztynSWDGridHotspotPOIData <- setRefClass(
  Class="OlsztynSWDGridHotspotPOIData",
  fields=list(
    categories="character",
    allColnames="character",
    propertiesColnames="character",
    r="numeric"
  ),
  methods = list(
    initialize = function() {
      name <<- "olsztynSWD"
      allColnames <<- c(const$poiCategories ,c("label"))
      propertiesColnames <<- const$poiCategories
      r <<- 200
    },
    extractData = function(params = NULL) {
      categories <<- extractCategories()
    },
    readData = function() {
      read.csv(const$olsztynSWDGridHotSpotPath, sep = ",")
    },
    extractCategories = function() {
      c('BOJ', 'CHU', 'FIN', 'INN', 'INT', 'KOM', 'KRA', 'KRY', 'ROZ', 'ZAT', 'ZGO')
    },
    getData = function(category) {
      categoryPath <- paste(const$olsztynSWDGridHotSpotPath, 'poi', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data$label <- factor(data$label)
      data[, allColnames]
    },
    getTestData = function(category) {
      categoryPath <- paste(const$olsztynSWDGridHotSpotPath, 'poi', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data[, propertiesColnames]
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