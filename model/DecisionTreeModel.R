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
      if(exists("decisionTreeParams")) {
        print("Decision Tree with params")
        rcontrol <- rpart.control(minsplit = decisionTreeParams$minsplit, cp = decisionTreeParams$cp)
        model <<- rpart(label~., data=trainData, control = rcontrol)
      } else {
        model <<- rpart(label~., data=trainData)
      }
      model
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
