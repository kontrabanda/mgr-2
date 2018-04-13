library(lubridate)
library(dplyr)
source(file="./data/bialystok/BialystokPOIDistData.R")

BialystokPOIDensWithoutGeoData <- setRefClass(
  Class="BialystokPOIDensWithoutGeoData",
  fields=list(
    rname="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bialystok"
      allColnames <<- c(c("day", "month", "category"), const$poiCategories)
      propertiesColnames <<- c(c("day", "month"), const$poiCategories)
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