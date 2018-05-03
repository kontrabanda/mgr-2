source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'olsztyn_SWD_grid_poi'
inputParams$methodName <- 'random_forest'
inputParams$poiRadius <- 200
inputParams$taskType <- 'hotspot'
