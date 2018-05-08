source(file="./model/ClassificationModelBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/SaveAdditionalMethodInformation.R")
source(file="./strategy/Classification.R")

HotspotClassification <- setRefClass(
  Class="HotspotClassification",
  fields=list(
    ClassificationModel="refObjectGenerator",
    saveAdditionalMethodInformation="SaveAdditionalMethodInformation",
    saveResults="SaveResults",
    name="character"
  ),
  methods = list(
    classify = function(dataClass, trainIndexes, testIndexes, category, fileName) {
      trainData <- dataClass$getData(category)[trainIndexes, ]
      testData <- dataClass$getTestData(category)[testIndexes, , drop = F]
      classficationModel <- ClassificationModel()
      classficationModel$trainModel(trainData)
      results <- classficationModel$predictLabels(testData)
      
      saveAdditionalData(classficationModel$getAdditionalInformation(), category, fileName)
      saveAdditionalPlot(classficationModel, category, fileName)
      
      results <- data.frame(results)
      retValue <- cbind(testData, '0'=results$X0, '1'=results$X1, label=dataClass$getData(category)[testIndexes, ]$label)
      saveResults$save(category, fileName, retValue)
      retValue
    }
  ),
  contains = c('Classification')
)