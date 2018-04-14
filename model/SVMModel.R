library(liquidSVM)
source(file="./model/ClassificationModelBase.R")

SVMModel <- setRefClass(
  Class="SVMModel",
  fields=list(
    model="liquidSVM"
  ),
  methods = list(
    initialize = function() {
      name <<- 'SVM'
    },
    trainModel = function(trainData) {
      trainData$label <- as.factor(ifelse(trainData$label==1, 1, 0))
      model <<- mcSVM(label~., trainData, threads=-1, partition_choice=6, predict.prob = T)
    },
    predictLabels = function(testData) {
      pred <- predict(model, testData)
      names(pred) <- gsub("vsOthers", "", names(pred))
      pred
    }
  ),
  contains=c("ClassificationModelBase")
)
