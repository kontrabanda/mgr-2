computeDataSourceVariableImportance <- function(dataSourceDir) {
  randomForestPath <- paste(dataSourceDir, 'randomForest', sep = '/')
  randomForestAdditionalDirs <- dir(randomForestPath)
  randomForestAdditionalDirs <- randomForestAdditionalDirs[!randomForestAdditionalDirs %in% c('logTime', 'Overall.csv', 'rating')]
  
  regExp <- paste(resultsPath, '.*/(.*)$', sep = '')
  dataSourceName <- gsub(regExp, '\\1', dataSourceDir)
  print(dataSourceName)
  for(categoryName in randomForestAdditionalDirs) {
    computeForSingleCategory(dataSourceName, randomForestPath, categoryName)
  }
}

computeForSingleCategory <- function(dataSourceName, randomForestPath, categoryName) {
  randomForestCategoryPath <- paste(randomForestPath, categoryName, sep = '/')
  variableImortancePaths <- list.files(randomForestCategoryPath, pattern = 'additional_data.csv$', recursive = T, full.names = T)
  data <- NULL
  print(categoryName)
  for(singlePath in variableImortancePaths) {
    if(is.null(data)) {
      readData <- read.csv(singlePath)
      data <- readData[order(readData[, 1]), 1:2]
    } else {
      readData <- read.csv(singlePath)
      readData <- readData[order(readData[, 1]), ]
      data <- cbind(data, readData[, 2])
    }
  }
  
  if(ncol(data) > 2) {
    result <- data.frame(name = data$X, value = rowMeans(data[, 2:ncol(data)]))
  } else {
    result <- data.frame(name = data$X, value = data$X0)
  }

  result <- result[order(result$value), ]
  
  path <- paste(ratingResultsPath, dataSourceName, sep = '/')
  dir.create(path)
  path <- paste(path, categoryName, sep = '/')
  filePath <- paste(path, 'csv', sep = '.')
  plotPath <- paste(path, 'png', sep = '.')
  write.csv(x = result, file = filePath)
  
  png(plotPath, 2000, 2000, res=300)
  dotchart(result$value, labels = result$name, xlab = 'Mean Decrease Accuracy', main = 'Variable Importance')
  dev.off()
}

###################################################################

resultsPath <- paste('../results', experimentName, sep = '/')
ratingResultsPath <- paste('../ratings', experimentName, 'variable-importance', sep = '/')

dir.create('../ratings')
dir.create(ratingResultsPath)

dataSourcesDirs <- list.dirs(resultsPath, recursive = F, full.names = T)

for(singleDir in dataSourcesDirs) {
  computeDataSourceVariableImportance(singleDir)
}
