source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_poi'
inputParams$methodName <- 'svm'
inputParams$poiRadius <- 200
inputParams$taskType <- 'hotspot-element'
