#library(kknn)
library('class')
source(file="./model/ClassificationModelBase.R")

KNNModel <- setRefClass(
  Class="KNNModel",
  fields=list(
    trainData="data.frame"
  ),
  methods = list(
    initialize = function() {
      name <<- 'kNN'
    },
    trainModel = function(data) {
      trainData <<- data
    },
    predictLabels = function(testData) {
      #results <- kknn(formula = label~., trainData, testData, k = 10)
      #results$prob
      trainWithoutLabel <- trainData[,-which(names(trainData) == "label")]
      trainWithoutLabel <- sapply(trainWithoutLabel, function(x) as.numeric(x))
      testData <- sapply(testData, function(x) as.numeric(x))
      
      res <- knn(trainWithoutLabel, testData, factor(trainData$label), k = 3, prob=TRUE)
      #attributes(res)$prob
      
      #predRes <- knn$predictLabels(test)
      prob <- as.numeric(attributes(res)$prob)
      
      resultWithWinningProb <- data.frame(label = res, prob = prob)
      
      temp <- apply(resultWithWinningProb, 1 , function(x) {
        res <- c()
        prob <- as.numeric(x['prob'])
        if(x['label'] == 0) {
          res[1] <- prob
          res[2] <- 1 - prob
        } else {
          res[1] <- 1 - prob
          res[2] <- prob
        }
        
        names(res) <- c('0', '1')
        res
      })
      
      temp <- t(temp)
      data.frame(X0=temp[,1], X1=temp[,2])
    }
  ),
  contains=c("ClassificationModelBase")
)
