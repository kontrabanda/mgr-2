source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_weather'
inputParams$methodName <- 'knn'
inputParams$monthInterval <- 3
inputParams$fromYear <- 2015
inputParams$poiRadius <- 200
