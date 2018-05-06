source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_olsztyn_swd_element'
inputParams$methodName <- 'random_forest'
inputParams$poiRadius <- 100
inputParams$taskType <- 'two-cities'