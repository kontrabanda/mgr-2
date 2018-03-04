library(ROCR)
source(file = "./rating/SaveRating.R")
source(file = "./strategy/ReadResults.R")

BinaryRating <- setRefClass(
  Class="BinaryRating",
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
        computeRatingForCategory(category)
      }
      
      aucSummary <- getAucSummary()
      saveRating$saveAuc(aucSummary)
      aucSummary
    },
    computeRatingForCategory = function(category) {
      readResults <- ReadResults(methodName, dataClass$name, classificationName, category)
      data <- readResults$read()
      pr <- prediction(data$getProbabilites(), data$getLabel())
      
      computeAuc(category, pr)
      computeRoc(category, pr)
    },
    computeRoc = function(category, pr) {
      roc <- performance(pr, measure = "tpr", x.measure = "fpr")
      saveRating$saveRoc(category, roc)
    },
    computeAuc = function(category, pr) {
      auc <- performance(pr, measure = "auc")
      el <- data.frame(category = as.character(category), value = auc@y.values[[1]])
      aucs <<- rbind(aucs, el)
    },
    getAucSummary = function() {
      aucOverall <- data.frame(category = 'overall', value = mean(aucs$value))
      rbind(aucs, aucOverall)
    }
  )
)
