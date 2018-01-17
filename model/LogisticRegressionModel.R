source(file="./model/ClassificationModelBase.R")

LogisticRegressionModel <- setRefClass(
  Class="LogisticRegressionModel",
  fields=list(
    model="lm"
  ),
  methods = list(
    initialize = function() {
      name <<- 'logicRegression'
    },
    trainModel = function(trainData) {
      model <<- glm(label~., family=binomial(link='logit'), data=trainData)
    },
    predictLabels = function(testData) {
      result <- data.frame(matrix(NA, nrow = nrow(testData), ncol = 2))
      colnames(result) <- c(1, 0)
      result[, 1] <- predict(model, newdata = testData, type = 'response')
      result[, 2] <- 1 - result[, 1]
      result
    }
  ),
  contains=c("ClassificationModelBase")
)