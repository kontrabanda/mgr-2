library(methods) # for Rscript

args = commandArgs(trailingOnly=TRUE)

cityName <- args[1]
r <- as.numeric(args[2])

if(is.na(r)) {
  stop('r not set')
}

if(cityName == 'bialystok') {
  source(file = './scripts/additional/poi/bialystokPOIDensity.R')
} else if(cityName == 'bournemouth') {
  source(file = './scripts/additional/poi/bournemouthPOIDensity.R')
} else if(cityName == 'boston') {
  source(file = './scripts/additional/poi/bostonPOIDensity.R')
} else {
  stop('No such dataset!')
}
