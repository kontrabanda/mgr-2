library(randomForest)
source(file="./model/ClassificationModelClass.R")
setOldClass("randomForest.formula")

RandomForestModelClass <- setRefClass(
  Class="RandomForestModelClass",
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
  contains=c("ClassificationModelClass")
)
