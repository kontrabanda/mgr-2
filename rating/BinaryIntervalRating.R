library(ROCR)
source(file = "./rating/SaveRating.R")
source(file = "./strategy/ReadResults.R")

BinaryIntervalRating <- setRefClass(
  Class="BinaryIntervalRating",
  fields=list(
    dataClass="DataBase",
    aucs="data.frame",
    saveRating="SaveRating",
    methodName="character",
    classificationName="character"
  ),
  methods = list(
    initialize = function(methodName, dataClass = NULL, ClassificationModel = NULL) {
      dataClass <<- dataClass
      classificationModel <- ClassificationModel()
      classificationName <<- classificationModel$name
      methodName <<- methodName
      saveRating <<- SaveRating(methodName, dataClass$name, classificationName)
      aucs <<- createAucs()
    },
    createAucs = function() {
      categoriesNames <- dataClass$getClassificationCategories()
      aucsResults <- data.frame(data.frame(matrix(NA, nrow = 0, ncol = 2)))
      colnames(aucsResults) <- c('category', 'value')
      aucsResults
    },
    computeRating = function() {
      for(category in dataClass$getClassificationCategories()) {
        computeRatingForEveryInterval(category)
      }
    },
    computeRatingForEveryInterval = function(category) {
      readResults <- ReadResults(methodName, dataClass$name, classificationName, category)
      results <- readResults$readAsList()
      
      for(i in 1:length(results)) {
        name <- names(results)[i]
        data <- results[[i]]
        pr <- prediction(data$getProbabilites(), data$getLabel())
        computeAuc(name, pr)
      }
      
      saveRating$saveIntervalAuc(getAucSummary(), category)
      aucs <<- createAucs()
    },
    computeAuc = function(dataName, pr) {
      auc <- performance(pr, measure = "auc")
      el <- data.frame(name = dataName, value = auc@y.values[[1]])
      aucs <<- rbind(aucs, el)
    },
    getAucSummary = function() {
      aucOverall <- data.frame(name = 'overall', value = mean(aucs$value))
      rbind(aucs, aucOverall)
    }
  )
)
