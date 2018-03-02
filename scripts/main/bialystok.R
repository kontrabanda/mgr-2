source(file="./util.R")
source(file="./data/bialystok/BialystokData.R")
source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
source(file="./data/bialystok/BialystokPOIDistData.R")
source(file="./data/bialystok/BialystokPOIDensData.R")

bialystokData <- BialystokData()
bialystokData <- BialystokDataWithoutDuplicates()
bialystokData <- BialystokPOIDistData()
bialystokData <- BialystokPOIDensData('r100')
methodName <- 'time-cross-validation'




### Logistic Regression
crossValidation <- TimeCrossValidation(methodName, bialystokData, LogisticRegressionModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, LogisticRegressionModel)
binaryRating$computeRating()

### Naive Bayes
crossValidation <- TimeCrossValidation(methodName, bialystokData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, NaiveBayesModel)
binaryRating$computeRating()

### kNN
crossValidation <- TimeCrossValidation(methodName, bialystokData, KNNModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, KNNModel)
binaryRating$computeRating()

### Random forest
crossValidation <- TimeCrossValidation(methodName, bialystokData, RandomForestModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, RandomForestModel)
binaryRating$computeRating()

### SVM
crossValidation <- TimeCrossValidation(methodName, bialystokData, SVMModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, SVMModel)
binaryRating$computeRating()
