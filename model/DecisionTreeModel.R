library(rpart)
library(rpart.plot)
source(file="./model/ClassificationModelBase.R")
setOldClass("rpart")

DecisionTreeModel <- setRefClass(
  Class="DecisionTreeModel",
  fields=list(
    model="rpart"
  ),
  methods = list(
    initialize = function() {
      name <<- 'DecisionTree'
    },
    trainModel = function(trainData) {
      model <<- rpart(label~., data=trainData)
    },
    predictLabels = function(testData) {
      pred <- predict(model, newdata=testData)
      pred
    },
    hasPlot = function() {
      TRUE
    },
    getPlot = function() {
      prp(model)
    }
  ),
  contains=c("ClassificationModelBase")
)
