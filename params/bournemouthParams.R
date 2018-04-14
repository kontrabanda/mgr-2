source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bournemouth_poi_dens_w_geo'
inputParams$methodName <- 'svm'
inputParams$monthInterval <- 3
inputParams$fromYear <- 2016
inputParams$poiRadius <- 200
