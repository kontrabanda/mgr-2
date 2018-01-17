source(file="./model/ClassificationModelBase.R")

SaveResults <- setRefClass(
  Class="SaveResults",
  fields=list(
    mainPath="character"
  ),
  methods = list(
    initialize = function(classificatorName, categoryName) {
      mainPath <<- createMainPath('./results', classificatorName, categoryName)
    },
    createMainPath = function(containerPath, classificatorName, categoryName) {
      path <- containerPath
      dir.create(path)
      path <- paste(path, classificatorName, sep = '/')
      dir.create(path)
      path <- paste(path, categoryName, sep = '/')
      dir.create(path)
      path
    },
    save = function(iteration, results) {
      write.csv(results, file = getIterationPath(iteration))
    },
    getIterationPath = function(iteration) {
      path <- paste(mainPath, iteration, sep = '/')
      path <- paste(path, 'csv', sep = '.')
      path
    }
  )
)