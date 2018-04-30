library(methods) # for Rscript

args = commandArgs(trailingOnly=TRUE)

experimentName <- args[1]
paramsPath <- args[2]

if(is.na(experimentName)) {
  stop('Experiment name not set!')
}

if(is.na(paramsPath)) {
  stop('Params path not set!')
}

source(file = paramsPath)

if(inputParams$taskType == 'crime-category') {
  source(file = './scripts/crime-category/main.R')
} else if(inputParams$taskType == 'hotspot') {
  source(file = './scripts/hotspot/main.R')
}
