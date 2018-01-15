source(file="./model/ClassificationModelClass.R")

LogisticRegressionModelClass <- setRefClass(
  Class="LogisticRegressionModelClass",
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
      result <- data.frame(matrix(NA, nrow = nrow(testData), ncol = 1))
      colnames(result) <- c('result')
      result[, 1] <- predict(model, newdata = testData, type = 'response')
      result
    }
  ),
  contains=c("ClassificationModelClass")
)