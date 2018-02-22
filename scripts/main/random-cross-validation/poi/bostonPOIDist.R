source(file="./util.R")
source(file="./data/BostonPOIDistData.R")

methodName <- 'poiDist'
bostonData <- BostonPOIDistData()

### Logistic Regression
crossValidation <- CrossValidation(methodName, bostonData, LogisticRegressionModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bostonData, LogisticRegressionModel)
binaryRating$computeRating()

### Naive Bayes
crossValidation <- CrossValidation(methodName, bostonData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bostonData, NaiveBayesModel)
binaryRating$computeRating()

### kNN
crossValidation <- CrossValidation(methodName, bostonData, KNNModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bostonData, KNNModel)
binaryRating$computeRating()

### Random forest
crossValidation <- CrossValidation(methodName, bostonData, RandomForestModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bostonData, RandomForestModel)
binaryRating$computeRating()

### SVM
crossValidation <- CrossValidation(methodName, bostonData, SVMModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bostonData, SVMModel)
binaryRating$computeRating()