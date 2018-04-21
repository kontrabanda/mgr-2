library(methods)
options(warn=-1)

source(file = './scripts/hotspot-element/util.R')

args = commandArgs(trailingOnly=TRUE)

experimentName <- args[1]
paramsPath <- args[2]

source(file = paramsPath)

########################################

print(paste('Experiment name:', experimentName, sep = ' '))
print(paste('Data name:', inputParams$dataName, sep = ' '))
print(paste('Method name:', inputParams$methodName, sep = ' '))

########################################

source(file = './scripts/hotspot-element/mainCommon.R')

data <- dataMapping[[inputParams$dataName]]()
data$extractData(inputParams)
method <- methodMapping[[inputParams$methodName]]

crossValidationHotspot <- CrossValidationHotspot(experimentName, data, method)
crossValidationHotspot$crossValidation()

binaryRating <- BinaryRating(experimentName, data, method)
ratingResult <- binaryRating$computeRating()











