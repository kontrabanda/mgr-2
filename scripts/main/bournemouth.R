source(file="./util.R")
source(file="./data/bournemouth/BournemouthData.R")
source(file="./data/bournemouth/BournemouthDataWithoutDuplicates.R")
source(file="./data/bournemouth/BournemouthPOIDistData.R")
source(file="./data/bournemouth/BournemouthPOIDensData.R")

methodName <- 'time-cross-validation'

#data <- BournemouthData()
#data <- BournemouthDataWithoutDuplicates()
data <- BournemouthPOIDistData()
#data <- BournemouthPOIDensData('r100')

crossValidation <- TimeCrossValidation(methodName, data, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, data, NaiveBayesModel)
binaryRating$computeRating()
