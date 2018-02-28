library(lubridate)
library(dplyr)
source(file="./data/DataBase.R")

BournemouthPOIDensData <- setRefClass(
  Class="BournemouthPOIDensData",
  fields=list(
    rawData="data.frame",
    categories="character"
  ),
  methods = list(
    initialize = function(radius) {
      name <<- "bournemouth"
      bournemouthData <- read.csv(const$bournemouthPOIDensPaths[, rname])
      data <- setNames(data.frame(matrix(ncol = 5, nrow = nrow(bournemouthData))), c("lat", "lng", "month", "year", "category"))
      
      data$month <- as.factor(substring(bournemouthData$Date, 1, 4))
      data$year <- as.factor(substring(bournemouthData$Date, 6, 7))
      data$lat <- bournemouthData$Latitude
      data$lng <- bournemouthData$Longitude
      data$category <- bournemouthData$Crime.type
      data[, const$poiCategories] <- bournemouthData[, const$poiCategories]
      categories <<- as.character(unique(data$category))
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      groups <- c(c('lat', 'lng', 'month'), const$poiCategories)
      data <- data %>% group_by(.dots=groups) %>% summarize(category = makeCategoryList(category))
      rawData <<- data
    },
    getData = function(category) {
      columns <-  c(c("lat", "lng", "month", "year"), const$poiCategories)
      data <- rawData[, columns]
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getTestData = function() {
      columns <-  c(c("lat", "lng", "month", "year"), const$poiCategories)
      data <- rawData[, columns]
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("DataBase")
)