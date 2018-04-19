source(file="./model/ClassificationModelBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/SaveAdditionalMethodInformation.R")

HotspotClassification <- setRefClass(
  Class="HotspotClassification",
  fields=list(
    ClassificationModel="refObjectGenerator",
    saveAdditionalMethodInformation="SaveAdditionalMethodInformation",
    saveResults="SaveResults",
    name="character"
  ),
  methods = list(
    initialize = function(ClassificationModel = NULL, experimentName = '', dataName='') {

    },
    classify = function(dataClass, trainIndexes, testIndexes, category, fileName) {
      print('classification data')
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