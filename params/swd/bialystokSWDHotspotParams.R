source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_SWD_poi'
inputParams$methodName <- 'random_forest'
inputParams$poiRadius <- 100
inputParams$taskType <- 'hotspot'
