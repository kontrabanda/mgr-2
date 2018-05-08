library(lubridate)
source(file="./data/DataBase.R")

BournemouthGridOnePOIData <- setRefClass(
  Class="BournemouthGridOnePOIData",
  fields=list(
    categories="character",
    allColnames="character",
    propertiesColnames="character",
    r="numeric"
  ),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      allColnames <<- c(c('all') ,c("label"))
      propertiesColnames <<- c('all')
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
      categoryPath <- paste(const$bournemouthGridHotSpotPath, 'poi-one', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data$label <- factor(data$label)
      data[, allColnames]
    },
    getTestData = function(category) {
      categoryPath <- paste(const$bournemouthGridHotSpotPath, 'poi-one', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data[, propertiesColnames, drop=F]
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