library(lubridate)
library(dplyr)
source(file="./data/bournemouth/BournemouthPOIDistData.R")

BournemouthPOIDensWithoutGeoData <- setRefClass(
  Class="BournemouthPOIDensWithoutGeoData",
  fields=list(
    rname="character"
  ),
  methods = list(
    initialize = function() {
      name <<- "bournemouth"
      allColnames <<- c(c("month", "category"), const$poiCategories)
      propertiesColnames <<- c(c("month"), const$poiCategories)
    },
    extractData = function(params = NULL) {
      rname <<- paste('r', params$poiRadius, sep = '')
      callSuper(params)
    },
    readData = function() {
      read.csv(const$bournemouthPOIDensPaths[, rname])
    }
  ),
  contains=c("BournemouthPOIDistData")
)
