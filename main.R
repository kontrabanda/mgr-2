#install.packages(c('e1071', 'ROCR', 'lubridate', 'dplyr', 'caret', 'kknn'))
options(warn=-1)

library(methods) # for Rscript
source(file = './util.R')

args = commandArgs(trailingOnly=TRUE)

experimentName <- args[1]
dataName <- args[2] 
methodName <- args[3]

monthInterval <- args[4]
testFromYear <- args[5]

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

validMethodNames <- c('logistic_regression', 'bayes', 'knn', 'random_forest', 'svm')

if(is.na(methodName) || !(methodName %in% validMethodNames)) {
  message <- paste('Invalid method name! Was:', methodName, 'should be one of:', paste(validMethodNames, collapse=", "))
  stop(message)
}

if(is.na(monthInterval)) {
  monthInterval <- 3
}

if(is.na(testFromYear)) {
  testFromYear <- 1970
}

print(paste('Experiment name:', experimentName, sep = ' '))
print(paste('Data name:', dataName, sep = ' '))
print(paste('Method name:', methodName, sep = ' '))
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
  svm = SVMModel
)

data <- dataMapping[[dataName]]
method <- methodMapping[[methodName]]

##############################

crossValidation <- TimeCrossValidation(experimentName, data(), method, monthInterval = monthInterval, fromYear = testFromYear)
crossValidation$crossValidation()

binaryRating <- BinaryRating(experimentName, data(), method)
binaryRating$computeRating()



