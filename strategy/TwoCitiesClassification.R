source(file="./model/ClassificationModelBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/SaveAdditionalMethodInformation.R")
source(file="./strategy/Classification.R")

TwoCitiesClassification <- setRefClass(
  Class="TwoCitiesClassification",
  fields=list(
    ClassificationModel="refObjectGenerator",
    saveAdditionalMethodInformation="SaveAdditionalMethodInformation",
    saveResults="SaveResults",
    name="character"
  ),
  methods = list(
    classify = function(dataClass, category, fileName) {
      trainData <- dataClass$getData(dataClass$trainCityName, category)
      testData <- dataClass$getTestData(category)
      
      #print(paste('trainData: ', nrow(trainData), sep = ''))
      #print(head(trainData))
      #print(paste('testData: ', nrow(testData), sep = ''))
      #print(head(testData))
      
      classficationModel <- ClassificationModel()
      classficationModel$trainModel(trainData)
      results <- classficationModel$predictLabels(testData)
      
      saveAdditionalData(classficationModel$getAdditionalInformation(), category, fileName)
      saveAdditionalPlot(classficationModel, category, fileName)
      
      results <- data.frame(results)
      retValue <- cbind(testData, '0'=results$X0, '1'=results$X1, label=dataClass$getData(dataClass$testCityName, category)$label)
      saveResults$save(category, fileName, retValue)
      retValue
    }
  ),
  contains = c('Classification')
)