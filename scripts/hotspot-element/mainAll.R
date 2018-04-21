library(methods)
options(warn=-1)

source(file = './scripts/hotspot-element/util.R')

args = commandArgs(trailingOnly=TRUE)

experimentName <- args[1]
paramsPath <- args[2]

source(file = paramsPath)

##############################

print('All method script!')
print(paste('Experiment name:', experimentName, sep = ' '))
print(paste('Data name:', inputParams$dataName, sep = ' '))

##############################

source(file = './scripts/hotspot-element/mainCommon.R')

methodNames <- c('logistic_regression', 'bayes', 'Random Forest', 'SVM')

data <- dataMapping[[inputParams$dataName]]()
data$extractData(inputParams)

computeForSingleMethod <- function(method, methodName) {
  tryCatch(
    {
      print(paste('Method', methodName, 'start at', Sys.time(), sep = ' '))
      crossValidation <- CrossValidationHotspot(experimentName, data, method)
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
