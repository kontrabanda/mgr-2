source(file = "./logger/LoggerBase.R")

IterationLogger <- setRefClass(
  Class="IterationLogger",
  fields=list(
    name="character",
    results="data.frame",
    dataName="character",
    classficatorName="character"
  ),
  methods = list(
    initialize = function(dataName = '', classficatorName = '') {
      name <<- 'IterationTime'
      dataName <<- dataName
      classficatorName <<- classficatorName
      results <<- data.frame(matrix(NA, nrow = 0, ncol = 3))
      colnames(results) <<- c('start', 'end', 'diff')
    },
    start = function(i) {
      startTime <- Sys.time()
      results[i, 'start'] <<- format(startTime, "%H:%M:%S")
      startPrint(i, startTime)
    },
    startPrint = function(i, startTime) {
      startTimeFormat <- format(startTime, usetz = T)
      cat(sprintf('\nIteration: %s, start time: %s \n', i, startTimeFormat))
    },
    stop = function(i) {
      endTime <- Sys.time()
      startTime <- as.POSIXct(results[i, 'start'], format = "%H:%M:%S")
      results[i, 'end'] <<- format(endTime, "%H:%M:%S")
      diff <- endTime - startTime
      results[i, 'diff'] <<- format(diff, usetz = TRUE)
      stopPrint(i, endTime, diff)
    },
    stopPrint = function(i, endTime, diff) {
      endTimeFormat <- format(endTime, usetz = T)
      diffFormat <- format(diff, usetz = T)
      cat(sprintf('Iteration:  %s, end time: %s \n', i, endTimeFormat))
      cat(sprintf('Iteration:  %s, diff time: %s \n\n', i, diffFormat))
    },
    save = function() {
      write.csv(results, file = getSavePath(dataName, classficatorName))
      print(results)
    },
    getSavePath = function(dataName, classficatorName) {
      filePath <- paste(const$resultPath, dataName, classficatorName, name, sep = '/')
      filePath <- paste(filePath, 'csv', sep = '.')
      filePath
    }
  )
)