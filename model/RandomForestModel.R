library(randomForest)
source(file="./model/ClassificationModelBase.R")
setOldClass("randomForest.formula")

RandomForestModel <- setRefClass(
  Class="RandomForestModel",
  fields=list(
    model="randomForest.formula"
  ),
  methods = list(
    initialize = function() {
      name <<- 'randomForest'
    },
    trainModel = function(trainData) {
      model <<- randomForest(label ~ ., data = trainData)
    },
    predictLabels = function(testData) {
      predict(model, testData, type = 'prob')
    }
  ),
  contains=c("ClassificationModelBase")
)
