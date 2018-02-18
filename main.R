source(file="./const.R")

source(file="./data/BialystokData.R")
source(file="./data/BostonData.R")
source(file="./data/BournemouthData.R")

source(file="./data/BournemouthDataWithoutDuplicates.R")
source(file="./data/BostonDataWithoutDuplicates.R")
source(file="./data/BialystokDataWithoutDuplicates.R")

source(file="./model/LogisticRegressionModel.R")
source(file="./model/KNNModel.R")
source(file="./model/NaiveBayesModel.R")
source(file="./model/RandomForestModel.R")
source(file="./model/SVMModel.R")

source(file="./strategy/CrossValidation.R")
source(file="./rating/BinaryRating.R")

bialystokData <- BialystokData()
bournemouthData <- BournemouthData()
bostonData <- BostonData()

nrow(bialystokData$rawData)
nrow(bournemouthData$rawData)
nrow(bostonData$rawData)

bialystokData <- BialystokDataWithoutDuplicates()
bournemouthData <- BournemouthDataWithoutDuplicates()
bostonData <- BostonDataWithoutDuplicates()

nrow(bialystokData$rawData)
nrow(bournemouthData$rawData)
nrow(bostonData$rawData)

crossValidation <- CrossValidation(bialystokData, NaiveBayesModel)
crossValidation$crossValidation()






