#install.packages(c('e1071', 'ROCR', 'lubridate', 'dplyr', 'caret', 'kknn', 'liquidSVM', 'RandomForest'))
options(warn=-1)

library(methods) # for Rscript
source(file = './util.R')

args = commandArgs(trailingOnly=TRUE)

experimentName <- args[1]
paramsPath <- args[2]

##############################

if(is.na(experimentName)) {
  stop('Experiment name not set!')
}

if(is.na(paramsPath)) {
  stop('Params path not set!')
}

source(file = paramsPath)

if(is.na(inputParams)) {
  stop('Input params not set!!')
}

validDataNames <- c(
  'bialystok_norm', 'bialystok_poi_dist', 'bialystok_poi_dens', 'bialystok_weather',
  'bournemouth_norm', 'bournemouth_poi_dist', 'bournemouth_poi_dens',
  'boston_norm', 'boston_poi_dist', 'boston_poi_dens')

if(is.na(inputParams$dataName) || !(inputParams$dataName %in% validDataNames)) {
  message <- paste('Invalid data name! Was:', inputParams$dataName, 'should be one of:', paste(validDataNames, collapse=", "))
  stop(message)
}

print('All method script!')
print(paste('Experiment name:', experimentName, sep = ' '))
print(paste('Data name:', inputParams$dataName, sep = ' '))
print(paste('Month interval:', inputParams$monthInterval, sep = ' '))
print(paste('Test from year:', inputParams$fromYear, sep = ' '))

##############################

dataMapping <- list(
  bialystok_norm = BialystokDataWithoutDuplicates,
  bialystok_poi_dist = BialystokPOIDistData,
  bialystok_poi_dens = BialystokPOIDensData,
  bialystok_weather = BialystokWeatherData,
  
  bournemouth_norm = BournemouthDataWithoutDuplicates,
  bournemouth_poi_dist = BournemouthPOIDistData,
  bournemouth_poi_dens = BournemouthPOIDensData,
  
  boston_norm = BostonDataWithoutDuplicates,
  boston_poi_dist = BostonPOIDistData,
  boston_poi_dens = BostonPOIDensData
)

methodMapping <- list(
  logistic_regression = LogisticRegressionModel,
  bayes = NaiveBayesModel,
  knn = KNNModel,
  random_forest = RandomForestModel,
  svm = SVMModel,
  decision_tree = DecisionTreeModel
)

methodNames <- c('logistic_regression', 'bayes', 'kNN', 'Random Forest', 'SVM')

data <- dataMapping[[inputParams$dataName]]()
data$extractData(inputParams)

computeForSingleMethod <- function(method, methodName) {
  tryCatch(
    {
      print(paste('Method', methodName, 'start at', Sys.time(), sep = ' '))
      crossValidation <- TimeCrossValidation(experimentName, data, method, monthInterval = inputParams$monthInterval, fromYear = inputParams$fromYear)
      crossValidation$crossValidation()
      
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

i <- 1
for(method in methodMapping) {
  computeForSingleMethod(method, methodNames[i])
  i <- i + 1
}

