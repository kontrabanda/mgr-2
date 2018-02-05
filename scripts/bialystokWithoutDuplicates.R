source(file="./util.R")
source(file="./data/BialystokDataWithoutDuplicates.R")

bialystokData <- BialystokDataWithoutDuplicates()
methodName <- 'without-duplicats'

### Logistic Regression
crossValidation <- CrossValidation(methodName, bialystokData, LogisticRegressionModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, LogisticRegressionModel)
binaryRating$computeRating()

### Naive Bayes
crossValidation <- CrossValidation(methodName, bialystokData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, NaiveBayesModel)
binaryRating$computeRating()

### kNN
crossValidation <- CrossValidation(methodName, bialystokData, KNNModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, KNNModel)
binaryRating$computeRating()

### Random forest
crossValidation <- CrossValidation(methodName, bialystokData, RandomForestModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, RandomForestModel)
binaryRating$computeRating()

### SVM
crossValidation <- CrossValidation(methodName, bialystokData, SVMModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bialystokData, SVMModel)
binaryRating$computeRating()

