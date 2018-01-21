source(file="./result/BinaryResults.R")

ReadResults <- setRefClass(
  Class="ReadResults",
  fields=list(
    path="character"
  ),
  methods = list(
    initialize = function(dataName = '', classificatorName = '', categoryName = '') {
      path <<- getPath(dataName, classificatorName, categoryName)
    },
    getPath = function(dataName, classificatorName, categoryName) {
      resultPath <- paste(const$resultPath, dataName, classificatorName, categoryName, sep = '/')
    },
    read = function() {
      results <- NULL
      for(i in 1:10) {
        results <- rbind(results, getSingleResult(i))
      }
      binaryResults <- BinaryResults(results)
    },
    getSingleResult = function(iteration) {
      result <- read.csv(getIterationResultsPath(iteration))
      result
    },
    getIterationResultsPath = function(iteration) {
      resultPath <- paste(path, iteration, sep = '/')
      resultPath <- paste(resultPath, 'csv', sep = '.')
      resultPath
    }
  )
)