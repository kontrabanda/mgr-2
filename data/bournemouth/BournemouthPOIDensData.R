library(lubridate)
library(dplyr)
source(file="./data/bournemouth/BournemouthPOIDistData.R")

BournemouthPOIDensData <- setRefClass(
  Class="BournemouthPOIDensData",
  fields=list(
    rname="character"
  ),
  methods = list(
    initialize = function(rname) {
      name <<- "bournemouth"
      rname <<- rname
      allColnames <<- c(c("lat", "lng", "month", "category"), const$poiCategories)
      propertiesColnames <<- c(c("lat", "lng", "month"), const$poiCategories)
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