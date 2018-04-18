source(file="./util.R")
source(file="./data/boston/BostonData.R")
source(file="./data/boston/BostonDataWithoutDuplicates.R")
source(file="./data/boston/BostonPOIDistData.R")
source(file="./data/boston/BostonPOIDensData.R")

data <- BostonData()
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# coś jest nie tak z różnicą pomiędzy liczbą danych w BostonDataWithoutDuplicates i BostonPOIDistData
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
data <- BostonDataWithoutDuplicates()
data <- BostonPOIDistData()
data <- BostonPOIDensData('r100')

methodName <- 'time-cross-validation'

trainData <- data$getData('Larceny')
testData <- data$getTestData()

crossValidation <- TimeCrossValidation(methodName, data, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, data, NaiveBayesModel)
binaryRating$computeRating()

test <- data$readData()
