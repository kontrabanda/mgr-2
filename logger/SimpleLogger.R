source(file = "./logger/LoggerBase.R")

SimpleLogger <- setRefClass(
  Class="SimpleLogger",
  fields=list(
    name="character",
    methodName="character",
    dataName="character",
    classficatorName="character",
    startTime="POSIXct",
    endTime="POSIXct",
    diff="difftime"
  ),
  methods = list(
    initialize = function(methodName = '', dataName = '', classficatorName = '') {
      methodName <<- methodName
      name <<- 'Overall'
      dataName <<- dataName
      classficatorName <<- classficatorName
    },
    start = function() {
      startTime <<- Sys.time()
      startPrint()
    },
    startPrint = function() {
      startTimeFormat <- format(startTime, usetz = T)
      cat(sprintf('\n%s, start time: %s \n', name, startTimeFormat))
    },
    stop = function() {
      endTime <<- Sys.time()
      diff <<- endTime - startTime
      stopPrint()
      save()
    },
    stopPrint = function() {
      endTimeFormat <- format(endTime, usetz = T)
      diffFormat <- format(diff, usetz = T)
      cat(sprintf('%s, end time: %s \n', name, endTimeFormat))
      cat(sprintf('%s, diff time: %s \n\n', name, diffFormat))
    },
    save = function() {
      write.csv(getSaveData(), file = getSavePath())
    },
    getSavePath = function() {
      filePath <- paste(const$resultPath, methodName, dataName, classficatorName, name, sep = '/')
      filePath <- paste(filePath, 'csv', sep = '.')
      filePath
    },
    getSaveData = function() {
      data <- data.frame(name = 'startTime', value = format(startTime, usetz = T))
      data <- rbind(data, data.frame(name = 'endTime', value = format(endTime, usetz = T)))
      data <- rbind(data, data.frame(name = 'diff', value = format(diff, usetz = T)))
      data
    }
  )
)
