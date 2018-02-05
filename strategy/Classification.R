source(file="./model/ClassificationModelBase.R")

Classification <- setRefClass(
  Class="Classification",
  fields=list(
    ClassificationModel="refObjectGenerator",
    name="character"
  ),
  methods = list(
    initialize = function(ClassificationModel = NULL, dataName = '') {
      if(is.null(ClassificationModel)) return();
      
      ClassificationModel <<- ClassificationModel
      classficationModel <- ClassificationModel()
      name <<- classficationModel$name
    },
    classify = function(trainData, testData, iteration) {
      classficationModel <- ClassificationModel()
      classficationModel$trainModel(trainData)
      results <- classficationModel$predictLabels(testData)
      data.frame(results)
    }
  )
)