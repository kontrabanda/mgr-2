source(file="./const.R")

source(file="./data/BialystokData.R")
source(file="./data/BostonData.R")
source(file="./data/BournemouthData.R")

source(file="./model/LogisticRegressionModel.R")
source(file="./model/KNNModel.R")
source(file="./model/NaiveBayesModel.R")
source(file="./model/RandomForestModel.R")
source(file="./model/SVMModel.R")

source(file="./strategy/CrossValidation.R")
source(file="./rating/BinaryRating.R")

bialystokData <- BialystokData()


crossValidation <- CrossValidation(bialystokData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bialystokData, NaiveBayesModel)
binaryRating$computeRating()
