source(file="./util.R")
source(file="./data/BournemouthPOIDistData.R")

bournemouthData <- BournemouthPOIDistData()
methodName <- 'time-cross-validation'

head(bournemouthData$rawData)
