ReadResults <- setRefClass(
  Class="ReadResults",
  fields=list(
    path="character"
  ),
  methods = list(
    initialize = function(classificatorName = '', categoryName = '') {
      path <<- getPath(classificatorName, categoryName)
    },
    getPath = function(classificatorName, categoryName) {
      resultPath <- paste('./results', classificatorName, categoryName, sep = '/')
    },
    read = function() {
      results <- getSingleResult(1)
      for(i in 2:10) {
        results <- rbind(results, getSingleResult(i))
      }
      results
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