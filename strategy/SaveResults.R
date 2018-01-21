source(file="./model/ClassificationModelBase.R")

SaveResults <- setRefClass(
  Class="SaveResults",
  fields=list(
    mainPath="character"
  ),
  methods = list(
    initialize = function(dataName = '', classificatorName = '') {
      mainPath <<- createMainPath(dataName, classificatorName)
    },
    createMainPath = function(dataName, classificatorName) {
      path <- const$resultPath
      dir.create(path)
      path <- paste(path, dataName, sep = '/')
      dir.create(path)
      path <- paste(path, classificatorName, sep = '/')
      dir.create(path)
      path
    },
    save = function(categoryName, fileName, data) {
      write.csv(data, file = getPath(categoryName, fileName))
    },
    getPath = function(categoryName, fileName) {
      path <- paste(mainPath, categoryName, sep = '/')
      dir.create(path)
      path <- paste(path, fileName, sep = '/')
      path <- paste(path, 'csv', sep = '.')
      path
    }
  )
)