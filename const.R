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
    
    bialystokWeather="character",
    
    bialystokPOIDensPaths="data.frame",
    bostonPOIDensPaths="data.frame",
    bournemouthPOIDensPaths="data.frame",
    
    bialystokPopulation='character',
    bournemouthPopuplation='character'
  ),
  methods = list(
    initialize = function(classificatorName = '') {
      resultPath <<- '../results'
      bialystokDataPath <<- '../data/bialystok/crimes_bialystok.csv'
      bostonDataPath <<- '../data/boston/crimes_boston.csv'
      bournemouthDataPath <<- '../data/bournemouth/crimes_bournemouth.csv'
      
      poiCategories <<- c('shop', 'communication', 'money', 'education', 'security', 
                          'public', 'health', 'food', 'culture', 'turist', 
                          'services', 'sport', 'other')
      
      bialystokPOIPath <<- '../data/bialystok/bialystok_poi_dist.csv'
      bostonPOIPath <<- '../data/boston/boston_poi_dist.csv'
      bournemouthPOIPath <<- '../data/bournemouth/bournemouth_poi_dist.csv'
      
      bialystokPOIDensPaths <<- data.frame(r100 = '../data/bialystok/bialystok_poi_dens_100.csv', r200 = '../data/bialystok/bialystok_poi_dens_200.csv', r500 = '../data/bialystok/bialystok_poi_dens_500.csv', stringsAsFactors=FALSE)
      bostonPOIDensPaths <<- data.frame(r100 = '../data/boston/boston_poi_dens_100.csv', r200 = '../data/boston/boston_poi_dens_200.csv', r500 = '../data/boston/boston_poi_dens_500.csv', stringsAsFactors=FALSE)
      bournemouthPOIDensPaths <<- data.frame(r100 = '../data/bournemouth/bournemouth_poi_dens_100.csv', r200 = '../data/bournemouth/bournemouth_poi_dens_200.csv', r500 = '../data/bournemouth/bournemouth_poi_dens_500.csv', stringsAsFactors=FALSE)
      
      bialystokWeather <<- '../data/bialystok/crimes_with_weather.csv'
      
      bialystokPopulation <<- '../data/bialystok/crimes_bialystok_with_population.csv'
      bournemouthPopuplation <<- '../data/bournemouth/crimes_bournemouth_with_population.csv'
    }
  )
)

const <- Const()
