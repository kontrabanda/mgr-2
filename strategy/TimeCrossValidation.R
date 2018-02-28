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
    methodName="character",
    monthInterval="numeric",
    fromYear="numeric"
  ),
  methods = list(
    initialize = function(methodName, dataClass, ClassificationModel, monthInterval = 3, fromYear = 1970) {
      set.seed(123)
      dataClass <<- dataClass
      methodName <<- methodName
      monthInterval <<- monthInterval
      fromYear <<- fromYear
      
      classification <<- Classification(ClassificationModel, dataClass$name)
      saveResults <<- SaveResults(methodName, dataClass$name, classification$name)
      data <- dataClass$rawData
      date <<- data.frame(month = as.numeric(as.character(data$month)), year = as.numeric(as.character(data$year)))
      cuttingPoints <<- getCuttingPoints()
    },
    getCuttingPoints = function() {
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
      points <- points[points$year >= fromYear | (points$year == fromYear - 1 & points$month == monthCount), ]
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
      trainIndexes <- getTrainIndexes(iteration)
      testIndexes <- getTestIndexes(iteration)
      
      trainData <- dataClass$getData(category)[trainIndexes, ]
      testData <- dataClass$getTestData()[testIndexes, ]
      results <- classification$classify(trainData, testData, iteration)
      data <- cbind(testData, '0'=results$X0, '1'=results$X1, label=dataClass$getData(category)[testIndexes, ]$label)
      
      fileName <- paste(cuttingPoints[iteration, 1], cuttingPoints[iteration, 2], sep = '-')
      saveResults$save(category, fileName, data)
    },
    getTrainIndexes = function(iteration) {
      currPoint <- cuttingPoints[iteration, ]
      result <- date$year < currPoint$year | (date$year == currPoint$year & date$month <= currPoint$month)
      result
    },
    getTestIndexes = function(iteration) {
      currPoint <- cuttingPoints[iteration, ]
      nextPoint <- cuttingPoints[iteration + 1, ]
      result <- (date$year > currPoint$year | (date$year == currPoint$year & date$month > currPoint$month)) &
                (date$year < nextPoint$year | (date$year == nextPoint$year & date$month <= nextPoint$month))
      result
    }
  )
)
