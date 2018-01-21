library(caret)
source(file="./data/DataBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/Classification.R")

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
      classification <<- Classification(ClassificationModel)
      dataClass <<- dataClass
      saveResults <<- SaveResults(dataClass$name, classification$name)
      folds <<- setFolds()
    },
    setFolds = function() {
      createFolds(1:dataClass$getRowSize(), k = 10, list = FALSE)
    },
    crossValidation = function(sets = 1:10) {
      for(i in sets) {
        crossValidationIteration(i)
      }
    },
    crossValidationIteration = function(iteration) {
      for(category in dataClass$getClassificationCategories()) {
        singleCategoryIteration(category, iteration)
      }
    },
    singleCategoryIteration = function(category, iteration) {
      trainData <- dataClass$getData(category)[folds != iteration, ]
      testData <- dataClass$getTestData()[folds == iteration, ]
      results <- classification$classify(trainData, testData)
      
      data <- cbind(testData, results, label=dataClass$getData(category)[folds == iteration, ]$label)
      
      saveResults$save(category, iteration, data)
    }
  )
)