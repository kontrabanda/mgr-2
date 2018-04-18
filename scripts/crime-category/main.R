#install.packages(c('e1071', 'ROCR', 'lubridate', 'dplyr', 'caret', 'kknn', 'liquidSVM', 'RandomForest'))
options(warn=-1)

library(methods) # for Rscript
source(file = './scripts/crime-category/util.R')

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
  'bialystok_norm', 'bialystok_poi_dist', 'bialystok_poi_dens', 'bialystok_weather', 'bialystok_norm_weather', 'bialystok_population', 'bialystok_poi_dens_w_geo',
  'bournemouth_norm', 'bournemouth_poi_dist', 'bournemouth_poi_dens', 'bournemouth_population', 'bournemouth_poi_dens_w_geo',
  'boston_norm', 'boston_poi_dist', 'boston_poi_dens')

if(is.na(inputParams$dataName) || !(inputParams$dataName %in% validDataNames)) {
  message <- paste('Invalid data name! Was:', inputParams$dataName, 'should be one of:', paste(validDataNames, collapse=", "))
  stop(message)
}

validMethodNames <- c('logistic_regression', 'bayes', 'knn', 'random_forest', 'svm', 'decision_tree')

if(is.na(inputParams$methodName) || !(inputParams$methodName %in% validMethodNames)) {
  message <- paste('Invalid method name! Was:', inputParams$methodName, 'should be one of:', paste(validMethodNames, collapse=", "))
  stop(message)
}

print(paste('Experiment name:', experimentName, sep = ' '))
print(paste('Data name:', inputParams$dataName, sep = ' '))
print(paste('Method name:', inputParams$methodName, sep = ' '))
print(paste('Month interval:', inputParams$monthInterval, sep = ' '))
print(paste('Test from year:', inputParams$fromYear, sep = ' '))

##############################

dataMapping <- list(
  bialystok_norm = BialystokDataWithoutDuplicates,
  bialystok_poi_dist = BialystokPOIDistData,
  bialystok_poi_dens = BialystokPOIDensData,
  bialystok_weather = BialystokWeatherData,
  bialystok_norm_weather = BialystokNormalForWeatherIntervalData,
  bialystok_population = BialystokPopulationData,
  bialystok_poi_dens_w_geo = BialystokPOIDensWithoutGeoData,
  
  bournemouth_norm = BournemouthDataWithoutDuplicates,
  bournemouth_poi_dist = BournemouthPOIDistData,
  bournemouth_poi_dens = BournemouthPOIDensData,
  bournemouth_population = BournemouthPopulationData,
  bournemouth_poi_dens_w_geo = BournemouthPOIDensWithoutGeoData,
  
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

data <- dataMapping[[inputParams$dataName]]()
data$extractData(inputParams)
method <- methodMapping[[inputParams$methodName]]

##############################

crossValidation <- TimeCrossValidation(experimentName, data, method, monthInterval = inputParams$monthInterval, fromYear = inputParams$fromYear)
crossValidation$crossValidation()

print('Computing AUC and ROC...')

binaryRating <- BinaryRating(experimentName, data, method)
ratingResult <- binaryRating$computeRating()

print('AUC')
print(ratingResult)

##############################

#source(file = './scripts/additional/rating/aucForExperiment.R')

