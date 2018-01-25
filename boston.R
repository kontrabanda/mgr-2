source(file="./util.R")
source(file="./data/BostonData.R")

bostonData <- BostonData()

### Logistic Regression
crossValidation <- CrossValidation(bostonData, LogisticRegressionModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bostonData, LogisticRegressionModel)
binaryRating$computeRating()

### Naive Bayes
crossValidation <- CrossValidation(bostonData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bostonData, NaiveBayesModel)
binaryRating$computeRating()

### kNN
crossValidation <- CrossValidation(bostonData, KNNModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bostonData, KNNModel)
binaryRating$computeRating()

### Random forest
crossValidation <- CrossValidation(bostonData, RandomForestModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bostonData, RandomForestModel)
binaryRating$computeRating()

### SVM
crossValidation <- CrossValidation(bostonData, SVMModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bostonData, SVMModel)
binaryRating$computeRating()


