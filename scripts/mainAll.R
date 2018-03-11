#install.packages(c('e1071', 'ROCR', 'lubridate', 'dplyr', 'caret', 'kknn', 'liquidSVM', 'RandomForest'))
options(warn=-1)

library(methods) # for Rscript
source(file = './util.R')

args = commandArgs(trailingOnly=TRUE)

experimentName <- args[1]
dataName <- args[2] 

monthInterval <- as.numeric(args[3])
testFromYear <- as.numeric(args[4])

##############################

if(is.na(experimentName)) {
  stop('Experiment name not set!')
}

validDataNames <- c(
  'bialystok_norm', 'bialystok_poi_dist', 'bialystok_poi_dens',
  'bournemouth_norm', 'bournemouth_poi_dist', 'bournemouth_poi_dens',
  'boston_norm', 'boston_poi_dist', 'boston_poi_dens')

if(is.na(dataName) || !(dataName %in% validDataNames)) {
  message <- paste('Invalid data name! Was:', dataName, 'should be one of:', paste(validDataNames, collapse=", "))
  stop(message)
}

if(is.na(monthInterval)) {
  monthInterval <- 3
}

if(is.na(testFromYear)) {
  testFromYear <- 1970
}

print('All method script!')
print(paste('Experiment name:', experimentName, sep = ' '))
print(paste('Data name:', dataName, sep = ' '))
print(paste('Month interval:', monthInterval, sep = ' '))
print(paste('Test from year:', testFromYear, sep = ' '))

##############################

dataMapping <- list(
  bialystok_norm = BialystokDataWithoutDuplicates,
  bialystok_poi_dist = BialystokPOIDistData,
  bialystok_poi_dens = BialystokPOIDensData,
  
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

data <- dataMapping[[dataName]]

computeForSingleMethod <- function(method, methodName) {
  tryCatch(
    {
      crossValidation <- TimeCrossValidation(experimentName, data(), method, monthInterval = monthInterval, fromYear = testFromYear)
      crossValidation$crossValidation()
      
      print(paste('Computing AUC and ROC for', methodName, sep = ' '))
      
      binaryRating <- BinaryRating(experimentName, data(), method)
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

i <- 1
for(method in methodMapping) {
  computeForSingleMethod(method, methodNames[i])
  i <- i + 1
}

