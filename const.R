Const <- setRefClass(
  Class="Const",
  fields=list(
    resultPath="character",
    bialystokDataPath="character",
    bostonDataPath="character",
    bournemouthDataPath="character",
    
    poiCategories="character",
    
    bialystokPOIPath="character",
    bournemouthPOIPath="character",
    bostonPOIPath="character",
    
    bialystokPOIDensPaths="data.frame",
    bostonPOIDensPaths="data.frame",
    bournemouthPOIDensPaths="data.frame"
  ),
  methods = list(
    initialize = function(classificatorName = '') {
      resultPath <<- '../results'
      bialystokDataPath <<- '../data/zdarzenia_rsow_bialystok.csv'
      bostonDataPath <<- '../data/crime_only_boston.csv'
      bournemouthDataPath <<- '../data/crime_only_bournemouth.csv'
      
      poiCategories <<- c('shop', 'communication', 'money', 'education', 'security', 
                          'public', 'health', 'food', 'culture', 'turist', 
                          'services', 'sport', 'other')
      
      bialystokPOIPath <<- '../data/bialystok_poi_dist.csv'
      bostonPOIPath <<- '../data/boston_poi_dist.csv'
      bournemouthPOIPath <<- '../data/bournemouth_poi_dist.csv'
      
      bialystokPOIDensPaths <<- data.frame(r100 = '../data/bialystok_poi_dens_100.csv', r200 = '../data/bialystok_poi_dens_200.csv', r500 = '../data/bialystok_poi_dens_500.csv', stringsAsFactors=FALSE)
      bostonPOIDensPaths <<- data.frame(r100 = '../data/boston_poi_dens_100.csv', r200 = '../data/boston_poi_dens_200.csv', r500 = '../data/boston_poi_dens_500.csv', stringsAsFactors=FALSE)
      bournemouthPOIDensPaths <<- data.frame(r100 = '../data/bournemouth_poi_dens_100.csv', r200 = '../data/bournemouth_poi_dens_200.csv', r500 = '../data/bournemouth_poi_dens_500.csv', stringsAsFactors=FALSE)
    }
  )
)

const <- Const()
