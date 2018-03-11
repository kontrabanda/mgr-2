SaveAdditionalMethodInformation <- setRefClass(
  Class="SaveAdditionalMethodInformation",
  fields=list(
    experimentName='character',
    dataName = 'character',
    classificatorName = 'character'
  ),
  methods = list(
    initialize = function(experimentName = '', dataName = '', classificatorName = '') {
      experimentName <<- experimentName
      dataName <<- dataName
      classificatorName <<- classificatorName
    },
    save = function(data, categoryName, name) {
      write.csv(data, file = getPath(categoryName, name, 'additional_data.csv'))
    },
    savePlot = function(model, categoryName, name) {
      path <- getPath(categoryName, name, 'additional_plot.png')
      png(path, 2000, 2000, res=300)
      model$getPlot()
      dev.off()
    },
    getPath = function(categoryName, name, sufix) {
      path <- const$resultPath
      dir.create(path)
      path <- paste(path, experimentName, sep = '/')
      dir.create(path)
      path <- paste(path, dataName, sep = '/')
      dir.create(path)
      path <- paste(path, classificatorName, sep = '/')
      dir.create(path)
      path <- paste(path, categoryName, sep = '/')
      dir.create(path)
      path <- paste(path, 'additional', sep = '/')
      dir.create(path)
      fileName <- paste(name, sufix, sep = '_')
      path <- paste(path, fileName, sep = '/')
      path
    }
  )
)