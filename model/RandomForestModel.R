library(randomForest)
library(caret)
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
    },
    hasPlot = function() {
      TRUE
    },
    getPlot = function() {
      varImpPlot(model,type=2)
    },
    getAdditionalInformation = function() {
      varImp(model)
    }
  ),
  contains=c("ClassificationModelBase")
)
