source(file="./params/InputParams.R")

inputParams <- InputParams()
inputParams$dataName <- 'bialystok_SWD_grid_poi_one'
inputParams$methodName <- 'decision_tree'
inputParams$poiRadius <- 200
inputParams$taskType <- 'hotspot'

source(file="./params/model/DecisionTreeParams.R")
decisionTreeParams <- DecisionTreeParams()
decisionTreeParams$minsplit <- 10
decisionTreeParams$cp <- 0.0001 # dużo nie zmienia jeżeli ustawimy 0.001
