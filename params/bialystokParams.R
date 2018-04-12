source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_population'
inputParams$methodName <- 'knn'
inputParams$monthInterval <- 3
inputParams$fromYear <- 2010
inputParams$poiRadius <- 200
