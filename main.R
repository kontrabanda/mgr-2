source(file="./data/BialystokData.R")
source(file="./data/BostonData.R")
source(file="./data/BournemouthData.R")

source(file="./model/LogisticRegressionModel.R")
source(file="./model/KNNModel.R")
source(file="./model/NaiveBayesModel.R")
source(file="./model/RandomForestModel.R")
source(file="./model/SVMModel.R")

source(file="./strategy/Classification.R")

bialystokCrimeDataClass <- BialystokData()
categories <- bialystokCrimeDataClass$getClassificationCategories()
trainData <- bialystokCrimeDataClass$getData(categories[1])
trainData <- trainData[1:1000, ]
testData <- bialystokCrimeDataClass$getTestData()
testData <- testData[1001:2000, ]

classification <- Classification(LogisticRegressionModel)
result1 <- classification$classify(trainData, testData)

classification <- Classification(KNNModel)
result2 <- classification$classify(trainData, testData)

classification <- Classification(NaiveBayesModel)
result3 <- classification$classify(trainData, testData)

classification <- Classification(RandomForestModel)
result4 <- classification$classify(trainData, testData)

classification <- Classification(SVMModel)
result5 <- classification$classify(trainData, testData)

source(file="./strategy/SaveResults.R")

saveResults <- SaveResults('bayes', 'CHU')
saveResults$save(1, testData)







bostonCrimeDataClass <- BostonCrimeDataClass()
categories <- bostonCrimeDataClass$getClassificationCategories()
test <- bostonCrimeDataClass$getData(categories[1])

rm(bostonCrimeDataClass, categories, test)


bournemouthCrimeDataClass <- BournemouthCrimeDataClass()
categories <- bournemouthCrimeDataClass$getClassificationCategories()
test <- bournemouthCrimeDataClass$getData(categories[1])

rm(bournemouthCrimeDataClass, categories, test)
