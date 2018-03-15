resultsPath <- paste('../results', experimentName, sep = '/')
ratingResultsPath <- paste('../ratings', experimentName, sep = '/')

dir.create('../ratings')
dir.create(ratingResultsPath)

getMethodNameFromPath <- function(path) {
  gsub('.*/(.*)/rating/auc.csv', '\\1', path)
}

getAucsFromPaths <- function(dataSourceAucPaths) {
  methodNames <- c('category')
  results <- NULL
  
  for(singleAucPath in dataSourceAucPaths) {
    methodNames <- c(methodNames, getMethodNameFromPath(singleAucPath))
    methodAuc <- read.csv(file = singleAucPath)
    
    if(is.null(results)) {
      results <- methodAuc[, c('category', 'value')]
    } else {
      results <- cbind(results, methodAuc[, c('value')])
    }
  }
  
  names(results) <- methodNames
  namesOrder <- c('category', 'logicRegression', 'naiveBayes', 'kNN', 'DecisionTree', 'randomForest', 'SVM')
  results <- results[, namesOrder]
  results
}

formatAucs <- function(aucs) {
  result <- round(aucs[, !names(aucs) %in% c("category")], digits = 4)
  cbind(category = aucs$category, result)
}

getDataSourceNameFromPath <- function(path) {
  regExp <- paste(resultsPath, '.*/(.*)$', sep = '')
  gsub(regExp, '\\1', path)
}

saveAucs <- function(dataSourceName, aucs) {
  fileName <- paste(dataSourceName, 'Auc', '.csv', sep = '')
  path <- paste(ratingResultsPath, fileName, sep = '/')
  write.csv(file = path, x = aucs)
}
   
computeDataSourceAUC <- function(dataSourceDir) {
  dataSourceAucPaths <- list.files(dataSourceDir, patter = "auc.csv$", recursive = T, full.names = T)
  dataSourceName <- getDataSourceNameFromPath(dataSourceDir)
  aucs <- getAucsFromPaths(dataSourceAucPaths)
  aucs <- formatAucs(aucs)
  saveAucs(dataSourceName, aucs)
}

dataSourcesDirs <- list.dirs(resultsPath, recursive = F, full.names = T)

for(singleDir in dataSourcesDirs) {
  computeDataSourceAUC(singleDir)
}


