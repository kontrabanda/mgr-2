source(file="./util.R")
source(file="./data/bournemouth/BournemouthData.R")
source(file="./data/bournemouth/BournemouthDataWithoutDuplicates.R")
source(file="./data/bournemouth/BournemouthPOIDistData.R")
source(file="./data/bournemouth/BournemouthPOIDensData.R")

methodName <- 'time-cross-validation'

bournemouthData <- BournemouthData()
bournemouthData <- BournemouthDataWithoutDuplicates()
bournemouthData <- BournemouthPOIDistData()
bournemouthData <- BournemouthPOIDensData('r100')

trainData <- bournemouthData$getData('Anti-social behaviour')
testData <- bournemouthData$getTestData()


crossValidation <- TimeCrossValidation(methodName, bournemouthData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bournemouthData, NaiveBayesModel)
binaryRating$computeRating()
