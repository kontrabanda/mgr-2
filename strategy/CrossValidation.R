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
    initialize = function(methodName, dataClass, ClassificationModel) {
      set.seed(123)
      dataClass <<- dataClass
      classification <<- Classification(ClassificationModel, dataClass$name)
      saveResults <<- SaveResults(methodName, dataClass$name, classification$name)
      folds <<- setFolds()
    },
    setFolds = function() {
      createFolds(1:dataClass$getRowSize(), k = 10, list = FALSE)
    },
    crossValidation = function() {
      logger <- SimpleLogger(dataClass$name, classification$name)
      logger$start()
      for(category in dataClass$getClassificationCategories()) {
        crossValidationCategory(category)
      }
      logger$stop()
    },
    crossValidationCategory = function(category, sets = 1:10) {
      iterationLogger <- IterationLogger(dataClass$name, classification$name, as.character(category))
      for(i in sets) {
        iterationLogger$start(i)
        singleCategoryIteration(category, i)
        iterationLogger$stop(i)
      }
      iterationLogger$save()
    },
    singleCategoryIteration = function(category, iteration) {
      trainData <- dataClass$getData(category)[folds != iteration, ]
      testData <- dataClass$getTestData()[folds == iteration, ]
      results <- classification$classify(trainData, testData, iteration)
      data <- cbind(testData, '0'=results$X0, '1'=results$X1, label=dataClass$getData(category)[folds == iteration, ]$label)
      saveResults$save(category, iteration, data)
    }
  )
)