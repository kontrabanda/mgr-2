library(lubridate)
library(dplyr)
source(file="./data/bialystok/BialystokPOIDistData.R")

BialystokPOIDensData <- setRefClass(
  Class="BialystokPOIDensData",
  fields=list(
    rname="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c(c("lat", "lng", "day", "month", "category"), const$poiCategories)
      propertiesColnames <<- c(c("lat", "lng", "day", "month"), const$poiCategories)
    },
    extractData = function(params = NULL) {
      rname <<- paste('r', params$poiRadius, sep = '')
      callSuper(params)
    },
    readData = function() {
      read.csv(const$bialystokPOIDensPaths[, rname])
    }
  ),
  contains=c("BialystokPOIDistData")
)