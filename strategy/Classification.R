source(file="./model/ClassificationModelBase.R")

Classification <- setRefClass(
  Class="Classification",
  fields=list(
    ClassificationModel="refObjectGenerator",
    name="character"
  ),
  methods = list(
    initialize = function(ClassificationModel) {
      ClassificationModel <<- ClassificationModel
      classficationModel <- ClassificationModel()
      name <<- classficationModel$name
    },
    classify = function(trainData, testData) {
      classficationModel <- ClassificationModel()
      classficationModel$trainModel(trainData)
      classficationModel$predictLabels(testData)
    }
  )
)