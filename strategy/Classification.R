source(file="./model/ClassificationModelBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/SaveAdditionalMethodInformation.R")

Classification <- setRefClass(
  Class="Classification",
  fields=list(
    ClassificationModel="refObjectGenerator",
    saveAdditionalMethodInformation="SaveAdditionalMethodInformation",
    saveResults="SaveResults",
    name="character"
  ),
  methods = list(
    initialize = function(ClassificationModel = NULL, experimentName = '', dataName='') {
      if(is.null(ClassificationModel)) return();
      
      ClassificationModel <<- ClassificationModel
      classficationModel <- ClassificationModel()
      
      name <<- classficationModel$name
      saveResults <<- SaveResults(experimentName, dataName, name)
      saveAdditionalMethodInformation <<- SaveAdditionalMethodInformation(experimentName, dataName, name)
    },
    classify = function(dataClass, trainIndexes, testIndexes, category, fileName) {
      trainData <- dataClass$getData(category)[trainIndexes, ]
      testData <- dataClass$getTestData()[testIndexes, ]

      classficationModel <- ClassificationModel()
      classficationModel$trainModel(trainData)
      results <- classficationModel$predictLabels(testData)
      
      saveAdditionalData(classficationModel$getAdditionalInformation(), category, fileName)
      saveAdditionalPlot(classficationModel, category, fileName)
      
      results <- data.frame(results)
      retValue <- cbind(testData, '0'=results$X0, '1'=results$X1, label=dataClass$getData(category)[testIndexes, ]$label)
      saveResults$save(category, fileName, retValue)
      retValue
    },
    saveAdditionalData = function(additionalData, category, fileName) {
      if(is.null(additionalData)) return();
      print(paste('Save additional data for model: ', name, 'and category: ', category, sep = ' '))
      saveAdditionalMethodInformation$save(additionalData, category, fileName)
    },
    saveAdditionalPlot = function(model, category, fileName) {
      if(!model$hasPlot()) return();
      print(paste('Save additional plot for model: ', name, 'and category: ', category, sep = ' '))
      saveAdditionalMethodInformation$savePlot(model, category, fileName)
    }
  )
)