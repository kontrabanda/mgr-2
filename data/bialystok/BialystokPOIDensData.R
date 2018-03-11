library(lubridate)
library(dplyr)
source(file="./data/bialystok/BialystokPOIDistData.R")

BialystokPOIDensData <- setRefClass(
  Class="BialystokPOIDensData",
  fields=list(
    rname="character"
  ),
  methods = list(
    initialize = function(rname) {
      name <<- "bialystok"
      rname <<- rname
      allColnames <<- c(c("lat", "lng", "day", "month", "category"), const$poiCategories)
      propertiesColnames <<- c(c("lat", "lng", "day", "month"), const$poiCategories)
      extractData()
    },
    readData = function() {
      read.csv(const$bialystokPOIDensPaths[, rname])
    }
  ),
  contains=c("BialystokPOIDistData")
)