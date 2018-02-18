library(lubridate)
library(dplyr)
source(file="./data/DataBase.R")

BialystokPOIDensData <- setRefClass(
  Class="BialystokPOIDensData",
  fields=list(
    rawData="data.frame",
    categories="character"
  ),
  methods = list(
    initialize = function(rname) {
      name <<- "bialystok"
      crimeBialystokDF <- read.csv(const$bialystokDataPath, sep = ",")
      crimeBialystokDF$DATA <- as.Date(crimeBialystokDF$DATA, "%y/%m/%d")
      
      data <- setNames(data.frame(matrix(ncol = 6, nrow = nrow(crimeBialystokDF))), c("lat", "lng", "day", "month", "year", "category"))
      data$month <- as.factor(month(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$day <- as.factor(day(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$year <- as.factor(year(as.Date(crimeBialystokDF$DATA, "%y/%m/%d")))
      data$lat <- crimeBialystokDF$LAT
      data$lng <- crimeBialystokDF$LNG
      data$category <- crimeBialystokDF$KAT
      
      distPOIBialystok <- read.csv(const$bialystokPOIDensPaths[, rname])
      distPOIBialystok <- distPOIBialystok[, const$poiCategories]
      data[const$poiCategories] <- distPOIBialystok
      categories <<- as.character(unique(crimeBialystokDF$KAT))
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      groups <- c(c('lat', 'lng', 'day', 'month', 'year'), const$poiCategories)
      data <- data %>% group_by(.dots=groups) %>% summarize(category = makeCategoryList(category))
      rawData <<- data
    },
    getData = function(category) {
      columns <-  c(c("lat", "lng", "day", "month", "year"), const$poiCategories)
      data <- rawData[, columns]
      #data$label <- as.factor(ifelse(rawData$category==category, 1, 0))
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getTestData = function() {
      columns <-  c(c("lat", "lng", "day", "month", "year"), const$poiCategories)
      data <- rawData[, columns]
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)