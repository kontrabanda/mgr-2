source(file = "./logger/LoggerBase.R")

SimpleLogger <- setRefClass(
  Class="SimpleLogger",
  fields=list(
    name="character",
    startTime="POSIXct",
    endTime="POSIXct",
    diff="difftime"
  ),
  methods = list(
    initialize = function(name = '') {
      name <<- name
    },
    start = function() {
      startTime <<- Sys.time()
      startPrint()
    },
    startPrint = function() {
      startTimeFormat <- format(startTime, usetz = T)
      cat(sprintf('%s, start time: %s \n', name, startTimeFormat))
    },
    stop = function() {
      endTime <<- Sys.time()
      diff <<- endTime - startTime
      stopPrint()
    },
    stopPrint = function() {
      endTimeFormat <- format(endTime, usetz = T)
      diffFormat <- format(diff, usetz = T)
      cat(sprintf('%s, end time: %s \n', name, endTimeFormat))
      cat(sprintf('%s, diff time: %s \n', name, diffFormat))
      
    },
    save = function(dataName, classficatorName) {
      write.csv(getSaveData(), file = getSavePath(dataName, classficatorName))
    },
    getSavePath = function(dataName, classficatorName) {
      filePath <- paste(const$resultPath, dataName, classficatorName, name, sep = '/')
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
