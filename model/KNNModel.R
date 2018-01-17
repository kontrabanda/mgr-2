library(kknn)
source(file="./model/ClassificationModelBase.R")

KNNModel <- setRefClass(
  Class="KNNModel",
  fields=list(
    trainData="data.frame"
  ),
  methods = list(
    initialize = function() {
      name <<- 'kNN'
    },
    trainModel = function(data) {
      trainData <<- data
    },
    predictLabels = function(testData) {
      results <- kknn(formula = label~., trainData, testData, k = 10)
      results$prob
    }
  ),
  contains=c("ClassificationModelBase")
)
