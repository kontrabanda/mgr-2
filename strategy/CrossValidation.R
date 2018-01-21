library(caret)
source(file="./data/DataBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/Classification.R")
source(file="./logger/SimpleLogger.R")
source(file="./logger/IterationLogger.R")

CrossValidation <- setRefClass(
  Class="CrossValidation",
  fields=list(
    classification="Classification",
    saveResults="SaveResults",
    dataClass="DataBase",
    folds="integer"
  ),
  methods = list(
    initialize = function(dataClass, ClassificationModel) {
      dataClass <<- dataClass
      classification <<- Classification(ClassificationModel, dataClass$name)
      saveResults <<- SaveResults(dataClass$name, classification$name)
      folds <<- setFolds()
    },
    setFolds = function() {
      createFolds(1:dataClass$getRowSize(), k = 10, list = FALSE)
    },
    crossValidation = function(sets = 1:10) {
      logger <- SimpleLogger(dataClass$name, classification$name)
      iterationLogger <- IterationLogger(dataClass$name, classification$name)
      logger$start()
      for(i in sets) {
        iterationLogger$start(i)
        crossValidationIteration(i)
        iterationLogger$stop(i)
      }
      logger$stop()
      iterationLogger$save()
    },
    crossValidationIteration = function(iteration) {
      for(category in dataClass$getClassificationCategories()) {
        singleCategoryIteration(category, iteration)
      }
    },
    singleCategoryIteration = function(category, iteration) {
      trainData <- dataClass$getData(category)[folds != iteration, ]
      testData <- dataClass$getTestData()[folds == iteration, ]
      results <- classification$classify(trainData, testData, iteration)
      
      data <- cbind(testData, results, label=dataClass$getData(category)[folds == iteration, ]$label)
      
      saveResults$save(category, iteration, data)
    }
  )
)