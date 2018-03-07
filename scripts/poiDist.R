library(methods) # for Rscript

args = commandArgs(trailingOnly=TRUE)

cityName <- args[1]

if(cityName == 'bialystok') {
  source(file = './scripts/additional/poi/bialystokPOIDist.R')
} else if(cityName == 'bournemouth') {
  source(file = './scripts/additional/poi/bournemouthPOIDist.R')
} else if(cityName == 'boston') {
  source(file = './scripts/additional/poi/bostonPOIDist.R')
} else {
  stop('No such dataset!')
}
