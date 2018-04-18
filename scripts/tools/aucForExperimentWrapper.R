options(warn=-1)

library(methods) # for Rscript

args = commandArgs(trailingOnly=TRUE)
experimentName <- args[1]

source(file = './scripts/additional/rating/aucForExperiment.R')