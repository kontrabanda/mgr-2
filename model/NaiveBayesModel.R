library(e1071)
source(file="./model/ClassificationModelBase.R")
setOldClass("naiveBayes")

NaiveBayesModel <- setRefClass(
  Class="NaiveBayesModel",
  fields=list(
    model="naiveBayes"
  ),
  methods = list(
    initialize = function() {
      name <<- 'naiveBayes'
    },
    trainModel = function(trainData) {
      model <<- naiveBayes(label ~ ., trainData)
    },
    predictLabels = function(testData) {
      predict(model, testData, type = 'raw')
    }
  ),
  contains=c("ClassificationModelBase")
)
