source(file="./util.R")
source(file="./data/bialystok/BialystokData.R")
source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
source(file="./data/bialystok/BialystokPOIDistData.R")
source(file="./data/bialystok/BialystokPOIDensData.R")

#bialystokData <- BialystokData()
bialystokData <- BialystokDataWithoutDuplicates()
#bialystokData <- BialystokPOIDistData()
#bialystokData <- BialystokPOIDensData('r100')
methodName <- 'time-cross-validation'
methodName <- 'test2'


train <- bialystokData$getData('CHU')[1:100,]
test <- bialystokData$getTestData()[200:300,]

nb <- NaiveBayesModel()
nb$trainModel(train)
res <- nb$predictLabels(test)

knn <- KNNModel()
knn$trainModel(train)

predRes <- knn$predictLabels(test)
prob <- as.numeric(attributes(predRes)$prob)

resultWithWinningProb <- data.frame(label = predRes, prob = prob)

temp <- apply(resultWithWinningProb, 1 , function(x) {
  res <- c()
  prob <- as.numeric(x['prob'])
  if(x['label'] == 0) {
    res[1] <- prob
    res[2] <- 1 - prob
  } else {
    res[1] <- 1 - prob
    res[2] <- prob
  }

  names(res) <- c('0', '1')
  res
})

temp <- t(temp)
data.frame(X0=temp[,1], X1=temp[,2])

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
