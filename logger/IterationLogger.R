source(file = "./logger/LoggerBase.R")

IterationLogger <- setRefClass(
  Class="IterationLogger",
  fields=list(
    name="character",
    results="data.frame",
    dataName="character",
    categoryName="character",
    classficatorName="character"
  ),
  methods = list(
    initialize = function(dataName = '', classficatorName = '', categoryName = '') {
      name <<- paste(categoryName, 'IterationTime', sep = '_')
      dataName <<- dataName
      categoryName <<- categoryName
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
      cat(sprintf('\n %s iteration: %s, start time: %s \n', categoryName, i, startTimeFormat))
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
      cat(sprintf(' %s iteration:  %s, end time: %s \n', categoryName, i, endTimeFormat))
      cat(sprintf(' %s iteration:  %s, diff time: %s \n\n', categoryName, i, diffFormat))
    },
    save = function() {
      write.csv(results, file = getSavePath(dataName, classficatorName))
      print(results)
    },
    getSavePath = function(dataName, classficatorName) {
      filePath <- paste(const$resultPath, dataName, classficatorName, 'logTime', sep = '/')
      dir.create(filePath)
      filePath <- paste(filePath, name, sep = '/')
      filePath <- paste(filePath, 'csv', sep = '.')
      filePath
    }
  )
)