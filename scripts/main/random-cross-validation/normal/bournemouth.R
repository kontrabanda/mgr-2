source(file="./util.R")
source(file="./data/BournemouthData.R")

bournemouthData <- BournemouthData()

### Logistic Regression
crossValidation <- CrossValidation(bournemouthData, LogisticRegressionModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bournemouthData, LogisticRegressionModel)
binaryRating$computeRating()

### Naive Bayes
crossValidation <- CrossValidation(bournemouthData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bournemouthData, NaiveBayesModel)
binaryRating$computeRating()

### kNN
crossValidation <- CrossValidation(bournemouthData, KNNModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bournemouthData, KNNModel)
binaryRating$computeRating()

### Random forest
crossValidation <- CrossValidation(bournemouthData, RandomForestModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bournemouthData, RandomForestModel)
binaryRating$computeRating()

### SVM
crossValidation <- CrossValidation(bournemouthData, SVMModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bournemouthData, SVMModel)
binaryRating$computeRating()


