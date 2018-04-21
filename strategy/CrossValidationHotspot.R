library(caret)
source(file="./data/DataBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/HotspotClassification.R")
source(file="./logger/SimpleLogger.R")
source(file="./logger/IterationLogger.R")

CrossValidationHotspot <- setRefClass(
  Class="CrossValidationHotspot",
  fields=list(
    #saveResults="SaveResults",
    classification="HotspotClassification",
    experimentName="character",
    dataClass="DataBase",
    folds="integer",
    k="numeric"
  ),
  methods = list(
    initialize = function(experimentName, dataClass, ClassificationModel) {
      set.seed(123)
      experimentName <<- experimentName
      dataClass <<- dataClass
      k <<- 10
      classification <<- HotspotClassification(ClassificationModel, experimentName, dataClass$name)
      #saveResults <<- SaveResults(methodName, dataClass$name, classification$name)
    },
    setFolds = function(category) {
      createFolds(1:nrow(dataClass$getData(category)), k = k, list = FALSE)
    },
    crossValidation = function() {
      logger <- SimpleLogger(experimentName, dataClass$name, classification$name)
      logger$start()
      for(category in dataClass$getCategories()) {
        crossValidationCategory(category)
      }
      logger$stop()
    },
    crossValidationCategory = function(category) {
      iterationLogger <- IterationLogger(experimentName, dataClass$name, classification$name, as.character(category))
      folds <<- setFolds(category)
      for(i in 1:k) {
        iterationLogger$start(i)
        singleCategoryIteration(category, i)
        iterationLogger$stop(i)
      }
      #iterationLogger$save()
    },
    singleCategoryIteration = function(category, iteration) {
      trainIndexes <- folds != iteration
      testIndexes <- folds == iteration
      
      classification$classify(dataClass, trainIndexes, testIndexes, category, iteration)
    }
  )
)