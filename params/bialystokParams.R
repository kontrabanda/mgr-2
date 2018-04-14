source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_poi_dens_w_geo'
inputParams$methodName <- 'svm'
inputParams$monthInterval <- 3
inputParams$fromYear <- 2010
inputParams$poiRadius <- 200
