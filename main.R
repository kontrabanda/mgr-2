source(file="./data/BialystokCrimeDataClass.R")
source(file="./data/BostonCrimeDataClass.R")
source(file="./data/BournemouthCrimeDataClass.R")

source(file="./model/LogisticRegressionModelClass.R")
source(file="./model/kNNModelClass.R")
source(file="./model/NaiveBayesModelClass.R")
source(file="./model/RandomForestModelClass.R")
source(file="./model/SVMModelClass.R")

bialystokCrimeDataClass <- BialystokCrimeDataClass()
categories <- bialystokCrimeDataClass$getClassificationCategories()
trainData <- bialystokCrimeDataClass$getData(categories[1])
trainData <- trainData[1:1000, ]
testData <- bialystokCrimeDataClass$getTestData()
testData <- testData[1001:2000, ]

logisticRegressionModelClass <- LogisticRegressionModelClass()
logisticRegressionModelClass$trainModel(trainData)
result <- logisticRegressionModelClass$predictLabels(testData)

knnModelClass <- kNNModelClass()
knnModelClass$trainModel(trainData)
result <- knnModelClass$predictLabels(testData)

naiveBayesModelClass <- NaiveBayesModelClass()
naiveBayesModelClass$trainModel(trainData)
result <- naiveBayesModelClass$predictLabels(testData)

randomForestModelClass <- RandomForestModelClass()
randomForestModelClass$trainModel(trainData)
result <- randomForestModelClass$predictLabels(testData)

svmModelClass <- SVMModelClass()
svmModelClass$trainModel(trainData)
result <- svmModelClass$predictLabels(testData)


rm(bialystokCrimeDataClass, categories, test)


bostonCrimeDataClass <- BostonCrimeDataClass()
categories <- bostonCrimeDataClass$getClassificationCategories()
test <- bostonCrimeDataClass$getData(categories[1])

rm(bostonCrimeDataClass, categories, test)


bournemouthCrimeDataClass <- BournemouthCrimeDataClass()
categories <- bournemouthCrimeDataClass$getClassificationCategories()
test <- bournemouthCrimeDataClass$getData(categories[1])

rm(bournemouthCrimeDataClass, categories, test)
