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

trainData <- bialystokData$getData('CHU')
testData <- bialystokData$getTestData()







crossValidation <- TimeCrossValidation(methodName, bialystokData, NaiveBayesModel, monthInterval = 3, fromYear = 2010)
crossValidation$crossValidation()

readResults <- ReadResults(methodName, bialystokData$name, 'naiveBayes', 'CHU')
results <- readResults$read()
results <- readResults$readAsList()

binaryRating <- BinaryRating(methodName, bialystokData, NaiveBayesModel)
binaryRating$computeRating()

binaryIntervalRating <- BinaryIntervalRating(methodName, bialystokData, NaiveBayesModel)
binaryIntervalRating$computeRating()





filesList <- list.files(path=readResults$path, pattern="*.csv")
filesData <- lapply(filesList, function(fileName) { read.csv(file = paste(readResults$path, fileName, sep = '/')) })

results <- NULL

for(fileName in filesList) {
  result <- rbind(result, read.csv(file = paste(readResults$path, fileName, sep = '/')))
}

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
