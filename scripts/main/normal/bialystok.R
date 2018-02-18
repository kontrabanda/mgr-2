source(file="./util.R")
source(file="./data/BialystokData.R")

bialystokData <- BialystokData()

### Logistic Regression
crossValidation <- CrossValidation(bialystokData, LogisticRegressionModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bialystokData, LogisticRegressionModel)
binaryRating$computeRating()

### Naive Bayes
crossValidation <- CrossValidation(bialystokData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bialystokData, NaiveBayesModel)
binaryRating$computeRating()

### kNN
crossValidation <- CrossValidation(bialystokData, KNNModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bialystokData, KNNModel)
binaryRating$computeRating()

### Random forest
crossValidation <- CrossValidation(bialystokData, RandomForestModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bialystokData, RandomForestModel)
binaryRating$computeRating()

### SVM
crossValidation <- CrossValidation(bialystokData, SVMModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bialystokData, SVMModel)
binaryRating$computeRating()

