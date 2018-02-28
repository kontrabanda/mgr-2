SaveRating <- setRefClass(
  Class="SaveRating",
  fields=list(
    aucPath="character",
    rocPath="character",
    ratingPath="character"
  ),
  methods = list(
    initialize = function(methodName = NULL, dataName = NULL, classificatorName = NULL) {
      if(!is.null(methodName) && !is.null(dataName) && !is.null(classificatorName)) {
        ratingPath <<- createRatingPath(methodName, dataName, classificatorName)
        aucPath <<- createAucPath()
        rocPath <<- createRocPath()
      }
    },
    createRatingPath = function(methodName, dataName, classificatorName) {
      path <- paste(const$resultPath, methodName, dataName, classificatorName, 'rating', sep = '/')
      dir.create(path)
      path
    },
    createAucPath = function() {
      path <- paste(ratingPath, 'auc.csv', sep = '/')
      path
    },
    createRocPath = function() {
      path <- paste(ratingPath, 'ROC', sep = '/')
      dir.create(path)
      path
    },
    saveAuc = function(auc) {
      write.csv(auc, file = aucPath)
    },
    saveIntervalAuc = function(auc, name) {
      path <- paste(ratingPath, name, sep = '/')
      path <- paste(path, 'csv', sep = '.')
      write.csv(auc, file = path)
    },
    saveRoc = function(category, roc) {
      fileName <- paste(as.character(category), 'png', sep = '.')
      filePath <- paste(rocPath, fileName, sep = '/')
      png(filePath, 2000, 2000, res=300)
      plot(roc)
      abline(a = 0, b = 1, col = 'red')
      dev.off()
    }
  )
)
