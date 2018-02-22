source(file="./result/BinaryResults.R")

ReadResults <- setRefClass(
  Class="ReadResults",
  fields=list(
    path="character"
  ),
  methods = list(
    initialize = function(methodName = '', dataName = '', classificatorName = '', categoryName = '') {
      path <<- getPath(methodName, dataName, classificatorName, categoryName)
    },
    getPath = function(methodName, dataName, classificatorName, categoryName) {
      resultPath <- paste(const$resultPath, methodName, dataName, classificatorName, categoryName, sep = '/')
    },
    read = function() {
      results <- NULL
      filesList <- list.files(path=readResults$path, pattern="*.csv")
      for(fileName in filesList) {
        results <- rbind(results, getSingleResult(fileName))
      }
      
      binaryResults <- BinaryResults(results)
    },
    getSingleResult = function(fileName) {
      resultPath <- paste(path, fileName, sep = '/')
      result <- read.csv(file = resultPath)
      result
    }
  )
)