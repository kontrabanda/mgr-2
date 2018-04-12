source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bournemouth_population'
inputParams$methodName <- 'knn'
inputParams$monthInterval <- 6
inputParams$fromYear <- 2016
inputParams$poiRadius <- 100
