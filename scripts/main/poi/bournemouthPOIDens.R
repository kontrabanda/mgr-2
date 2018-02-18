source(file="./util.R")
source(file="./data/BournemouthPOIDensData.R")

rname <- 'r100'
methodName <- paste('poiDens', rname, sep = '-')
bournemouthData <- BournemouthPOIDensData()

### Logistic Regression
crossValidation <- CrossValidation(methodName, bournemouthData, LogisticRegressionModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bournemouthData, LogisticRegressionModel)
binaryRating$computeRating()

### Naive Bayes
crossValidation <- CrossValidation(methodName, bournemouthData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bournemouthData, NaiveBayesModel)
binaryRating$computeRating()

### kNN
crossValidation <- CrossValidation(methodName, bournemouthData, KNNModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bournemouthData, KNNModel)
binaryRating$computeRating()

### Random forest
crossValidation <- CrossValidation(methodName, bournemouthData, RandomForestModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bournemouthData, RandomForestModel)
binaryRating$computeRating()

### SVM
crossValidation <- CrossValidation(methodName, bournemouthData, SVMModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(methodName, bournemouthData, SVMModel)
binaryRating$computeRating()