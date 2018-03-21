source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_poi_dens'
inputParams$methodName <- 'knn'
inputParams$monthInterval <- 6
inputParams$fromYear <- 2010
inputParams$poiRadius <- 100
