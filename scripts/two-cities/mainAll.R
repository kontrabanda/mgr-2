library(methods)
options(warn=-1)

source(file = './scripts/two-cities/util.R')

args = commandArgs(trailingOnly=TRUE)

experimentName <- args[1]
paramsPath <- args[2]

source(file = paramsPath)

##############################

print('All method script!')
print(paste('Experiment name:', experimentName, sep = ' '))
print(paste('Data name:', inputParams$dataName, sep = ' '))

##############################

dataMapping <- list(
  swd_bialystok_olsztyn = BialystokOlsztynSWDData
)

methodMapping <- list(
  logistic_regression = LogisticRegressionModel,
  bayes = NaiveBayesModel,
  knn = KNNModel,
  random_forest = RandomForestModel,
  svm = SVMModel,
  decision_tree = DecisionTreeModel
)

methodNames <- c('Logistic Regression', 'Naive Bayes', 'knn', 'Random Forest', 'SVM', 'Decision Tree')

data <- dataMapping[[inputParams$dataName]]()

computeForSingleMethod <- function(method, methodName) {
  tryCatch(
    {
      print(paste('Method', methodName, 'start at', Sys.time(), sep = ' '))
      ## todo tutaj dodać klasyfikację, tylko jak pogodzić dwa podejścia na raz? (że oba miasta na przemian)
      
      twoCities <- TwoCities(experimentName, data, method)
      twoCities$classify()
      
      print(paste('Computing AUC and ROC for', methodName, sep = ' '))
      
      binaryRating <- BinaryRating(experimentName, data, method)
      ratingResult <- binaryRating$computeRating()
      
      print(paste('AUC for ', methodName, sep = ' '))
      print(ratingResult)
      
      write(paste('Method', methodName, 'finish with SUCCESS'), '../log/progress.out', append=T)
    },
    error = function(cond) {
      message(paste('ERROR in', methodName, sep = ' '))
      message(cond)
      errMsg <- paste(Sys.time(), 'ERROR in', methodName, cond, sep = ' ')
      write(errMsg, '../log/errors.out', append=T)
      write(paste('Method', methodName, 'finish with ERROR'), '../log/progress.out', append=T)
    }
  )
}

write('', '../log/progress.out', append=F)
write('', '../log/errors.out', append=F)

data$extractData()
i <- 1
for(method in methodMapping) {
  computeForSingleMethod(method, methodNames[i])
  i <- i + 1
}

print('**********************COMPUTING REVERSE CITIES****************************')
## reverse
data$extractData(reverse = T)
i <- 1
for(method in methodMapping) {
  computeForSingleMethod(method, methodNames[i])
  i <- i + 1
}

