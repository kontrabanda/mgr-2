Const <- setRefClass(
  Class="Const",
  fields=list(
    resultPath="character",
    bialystokDataPath="character",
    bostonDataPath="character",
    bournemouthDataPath="character"
  ),
  methods = list(
    initialize = function(classificatorName = '') {
      resultPath <<- '../results'
      bialystokDataPath <<- '../../data/Polska/zdarzenia_rsow_bialystok.csv'
      bostonDataPath <<- '../../data/usa/crimes/crime_only_boston.csv'
      bournemouthDataPath <<- '../../data/gb/crimes/crime_only_bournemouth.csv'
    }
  )
)

const <- Const()
