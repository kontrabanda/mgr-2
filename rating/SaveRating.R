SaveRating <- setRefClass(
  Class="SaveRating",
  fields=list(
    aucPath="character",
    rocPath="character"
  ),
  methods = list(
    initialize = function(dataName = NULL, classificatorName = NULL) {
      if(is.null(dataName) || is.null(classificatorName)) return
      
      ratingPath <- createRatingPath(dataName, classificatorName)
      aucPath <<- createAucPath(ratingPath)
      rocPath <<- createRocPath(ratingPath)
    },
    createRatingPath = function(dataName, classificatorName) {
      path <- paste(const$resultPath, dataName, classificatorName, 'rating', sep = '/')
      dir.create(path)
      path
    },
    createAucPath = function(ratingPath) {
      path <- paste(ratingPath, 'auc.csv', sep = '/')
      path
    },
    createRocPath = function(ratingPath) {
      path <- paste(ratingPath, 'ROC', sep = '/')
      dir.create(path)
      path
    },
    saveAuc = function(auc) {
      write.csv(auc, file = aucPath)
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
