source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_olsztyn_swd_grid'
inputParams$methodName <- 'random_forest'
inputParams$poiRadius <- 200
inputParams$taskType <- 'two-cities'
