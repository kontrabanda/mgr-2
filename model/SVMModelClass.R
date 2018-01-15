library(liquidSVM)
source(file="./model/ClassificationModelClass.R")

SVMModelClass <- setRefClass(
  Class="SVMModelClass",
  fields=list(
    model="liquidSVM"
  ),
  methods = list(
    initialize = function() {
      name <<- 'svmModelClass'
    },
    trainModel = function(trainData) {
      trainData$label <- as.factor(ifelse(trainData$label==1, 1, -1))
      model <<- mcSVM(label~., trainData, threads=-1, partition_choice=6, predict.prob = T)
    },
    predictLabels = function(testData) {
      pred <- predict(model, testData)
      names(pred) <- gsub("vsOthers", "", names(pred))
      pred
    }
  ),
  contains=c("ClassificationModelClass")
)
