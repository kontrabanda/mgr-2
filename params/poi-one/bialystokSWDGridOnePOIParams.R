source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_SWD_grid_poi_one'
inputParams$methodName <- 'random_forest'
inputParams$poiRadius <- 200
inputParams$taskType <- 'hotspot'
