source(file="./util.R")
source(file="./data/BialystokData.R")

bialystokData <- BialystokData()

### Naive Bayes
crossValidation <- CrossValidation(bialystokData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bialystokData, NaiveBayesModel)
binaryRating$computeRating()

