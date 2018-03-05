library(methods) # for Rscript

args = commandArgs(trailingOnly=TRUE)

cityName <- args[1]

if(cityName == 'bialystok') {
  source(file = './scripts/additional/crimes-in-boundries/saveOnlyBialystokCrimes.R')
} else if(cityName == 'bournemouth') {
  source(file = './scripts/additional/crimes-in-boundries/saveOnlyBournemouthCrimes.R')
} else if(cityName == 'boston') {
  source(file = './scripts/additional/crimes-in-boundries/saveOnlyBostonCrimes.R')
} else {
  stop('No such dataset!')
}

