library(lubridate)
source(file="./data/DataBase.R")

OlsztynSWDGridOnePOIData <- setRefClass(
  Class="OlsztynSWDGridOnePOIData",
  fields=list(
    categories="character",
    allColnames="character",
    propertiesColnames="character",
    r="numeric"
  ),
  methods = list(
    initialize = function() {
      name <<- "olsztynSWD"
      allColnames <<- c(c('all') ,c("label"))
      propertiesColnames <<- c('all')
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
      categoryPath <- paste(const$olsztynSWDGridHotSpotPath, 'poi-one', r, category, sep = '/')
      categoryPath <- paste(categoryPath, '_poi_dens_', r, '.csv', sep = '')
      data <- read.csv(categoryPath)
      data$label <- factor(data$label)
      data[, allColnames]
    },
    getTestData = function(category) {
      categoryPath <- paste(const$olsztynSWDGridHotSpotPath, 'poi-one', r, category, sep = '/')
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