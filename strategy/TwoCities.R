library(caret)
source(file="./data/DataBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/TwoCitiesClassification.R")
source(file="./logger/SimpleLogger.R")
source(file="./logger/IterationLogger.R")

TwoCities <- setRefClass(
  Class="TwoCities",
  fields=list(
    classification="TwoCitiesClassification",
    experimentName="character",
    dataClass="DataBase"
  ),
  methods = list(
    initialize = function(experimentName, dataClass, ClassificationModel) {
      set.seed(123)
      experimentName <<- experimentName
      dataClass <<- dataClass
      classification <<- TwoCitiesClassification(ClassificationModel, experimentName, dataClass$name)
    },
    classify = function() {
      logger <- SimpleLogger(experimentName, dataClass$name, classification$name)
      logger$start()
      for(category in dataClass$getCategories()) {
        classifyCategory(category)
      }
      logger$stop()
    },
    classifyCategory = function(category) {
      iterationLogger <- IterationLogger(experimentName, dataClass$name, classification$name, as.character(category))
      iterationLogger$start(1)
      tryCatch({
        classification$classify(dataClass, category, 'result')
      }, error = function(cond) {
        message(paste('ERROR in ', dataClass$name, ' in method ', classification$name, ' in category ', category, sep = ''))
        message(cond)
      })
      iterationLogger$stop(1)
    }
  )
)