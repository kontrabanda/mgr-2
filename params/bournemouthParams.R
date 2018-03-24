source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bournemouth_poi_dist'
inputParams$methodName <- 'knn'
inputParams$monthInterval <- 3
inputParams$fromYear <- 2016
inputParams$poiRadius <- 100
