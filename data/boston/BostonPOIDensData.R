library(lubridate)
library(dplyr)
source(file="./data/boston/BostonPOIDistData.R")

BostonPOIDensData <- setRefClass(
  Class="BostonPOIDensData",
  fields=list(
    rname="character"
  ),
  methods = list(
    initialize = function(rname) {
      name <<- "boston"
      rname <<- rname
      allColnames <<- c(c("lat", "lng", "day", "month", "category"), const$poiCategories)
      propertiesColnames <<- c(c("lat", "lng", "day", "month"), const$poiCategories)
      extractData()
    },
    readData = function() {
      read.csv(const$bostonPOIDensPaths[, rname])
    }
  ),
  contains=c("BostonPOIDistData")
)