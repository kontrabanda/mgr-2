library(lubridate)
source(file="./data/DataBase.R")

BournemouthGridHotspotPOIData <- setRefClass(
  Class="BournemouthGridHotspotPOIData",
  fields=list(
    categories="character",
    allColnames="character",
    propertiesColnames="character",
    r="numeric"
  ),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      allColnames <<- c(const$poiCategories ,c("label"))
      propertiesColnames <<- const$poiCategories
      r <<- 200
    },
    extractData = function(params = NULL) {
      categories <<- extractCategories()
    },
    readData = function() {
      read.csv(const$bournemouthGridHotSpotPath, sep = ",")
    },
    extractCategories = function() {
      c('Anti-social behaviour', 'Bicycle theft', 'Burglary', 'Criminal damage and arson', 'Drugs', 
        'Other crime', 'Other theft', 'Possession of weapons', 'Public order', 'Robbery', 
        'Shoplifting', 'Theft from the person', 'Vehicle crime', 'Violence and sexual offences')
    },
    getData = function(category) {
      categoryPath <- paste(const$bournemouthGridHotSpotPath, 'poi', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data$label <- factor(data$label)
      data[, allColnames]
    },
    getTestData = function(category) {
      categoryPath <- paste(const$bournemouthGridHotSpotPath, 'poi', r, category, sep = '/')
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