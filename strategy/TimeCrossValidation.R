library(caret)
source(file="./data/DataBase.R")
source(file="./strategy/SaveResults.R")
source(file="./strategy/Classification.R")
source(file="./logger/SimpleLogger.R")
source(file="./logger/IterationLogger.R")

TimeCrossValidation <- setRefClass(
  Class="TimeCrossValidation",
  fields=list(
    classification="Classification",
    saveResults="SaveResults",
    dataClass="DataBase",
    date="data.frame",
    cuttingPoints="data.frame",
    methodName="character"
  ),
  methods = list(
    initialize = function(methodName, dataClass, ClassificationModel) {
      set.seed(123)
      dataClass <<- dataClass
      methodName <<- methodName
      classification <<- Classification(ClassificationModel, dataClass$name)
      saveResults <<- SaveResults(methodName, dataClass$name, classification$name)
      data <- dataClass$rawData
      date <<- data.frame(month = as.numeric(as.character(data$month)), year = as.numeric(as.character(data$year)))
      cuttingPoints <<- getCuttingPoints()
    },
    getCuttingPoints = function() {
      monthInterval <- 6 # wynieść wyżej
      fromYear <- 2010 #rok od którego zaczynamy liczyć -> wynieść wyżej
      
      firstYear <- min(unique(date$year))
      lastYear <- max(unique(date$year))
      monthCount <- 12
      toMonths <- 1:(monthCount/monthInterval) * monthInterval
      
      years <- c()
      months <- c()
      
      for(year in firstYear:lastYear) {
        for(i in toMonths) {
          years <- c(years, year)
          months <- c(months, i)
        }
      }
      
      points <- data.frame(year=years, month=months)
      points <- points[points$year > fromYear, ]
      points
    },
    crossValidation = function() {
      logger <- SimpleLogger(methodName, dataClass$name, classification$name)
      logger$start()
      for(category in dataClass$getClassificationCategories()) {
        crossValidationCategory(category)
      }
      logger$stop()
    },
    crossValidationCategory = function(category, sets = 1:10) {
      iterationLogger <- IterationLogger(methodName, dataClass$name, classification$name, as.character(category))
      for(i in 1:(nrow(cuttingPoints) - 1)) {
        iterationLogger$start(i)
        singleCategoryIteration(category, i)
        iterationLogger$stop(i)
      }
      iterationLogger$save()
    },
    singleCategoryIteration = function(category, iteration) {
      currPoint <- cuttingPoints[iteration, ]
      nextPoint <- cuttingPoints[iteration + 1, ]
      
      trainIndexes <- date$year < currPoint$year | (date$year == currPoint$year & date$month < currPoint$month)
      testIndexes <- (date$year > currPoint$year | (date$year == currPoint$year & date$month > currPoint$month)) &
                     (date$year < nextPoint$year | (date$year == nextPoint$year & date$month < nextPoint$month))
      
      trainData <- dataClass$getData(category)[trainIndexes, ]
      testData <- dataClass$getTestData()[testIndexes, ]
      results <- classification$classify(trainData, testData, iteration)
      data <- cbind(testData, '0'=results$X0, '1'=results$X1, label=dataClass$getData(category)[testIndexes, ]$label)
      saveResults$save(category, iteration, data)
    },
    getTrainIndexes = function() {
      currPoint <- cuttingPoints[iteration, ]
    },
    getTestIndexes = function() {
      currPoint <- cuttingPoints[iteration, ]
      nextPoint <- cuttingPoints[iteration + 1, ]
    }
  )
)
