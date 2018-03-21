library(lubridate)
library(dplyr)
source(file="./data/bialystok/BialystokData.R")

BialystokDataWithoutDuplicates <- setRefClass(
  Class="BialystokDataWithoutDuplicates",
  fields=list(),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c("lat", "lng", "day", "month", "category")
      propertiesColnames <<- c("lat", "lng", "day", "month")
    },
    parseData = function(inputData) {
      data <- callSuper(inputData)
      makeCategoryList <- function(arg) {
        list(unique(arg))
      }
      # year should stay to get year column for time cross validation points computing
      data <- data %>% group_by(lat, lng, day, month, year) %>% summarize(category = makeCategoryList(category))
      data
    },
    getData = function(category) {
      data <- rawData[, propertiesColnames]
      label <- sapply(rawData$category, function(x) category %in% x)
      data$label <- as.factor(ifelse(label, 1, 0))
      data
    },
    getClassificationCategories = function() {
      categories
    }
  ),
  contains=c("BialystokData")
)