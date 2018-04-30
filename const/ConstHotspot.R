ConstHotspot <- setRefClass(
  Class="ConstHotspot",
  fields=list(
    resultPath="character",
    bialystokHotSpotPath="character",
    bournemouthHotSpotPath="character",
    
    bialystokGridHotSpotPath="character",
    bournemouthGridHotSpotPath="character",
    
    poiCategories="character"
  ),
  methods = list(
    initialize = function(classificatorName = '') {
      resultPath <<- '../results'
      
      bialystokHotSpotPath <<- '../data/points-in-hotspots/bialystok'
      bournemouthHotSpotPath <<- '../data/points-in-hotspots/bournemouth'
      
      bialystokGridHotSpotPath <<- '../data/hotspot-grid/bialystok'
      bournemouthGridHotSpotPath <<- '../data/hotspot-grid/bournemouth'
      
      poiCategories <<- c('shop', 'communication', 'money', 'education', 'security', 
                          'public', 'health', 'food', 'culture', 'turist', 
                          'services', 'sport', 'other')
    }
  )
)

const <- ConstHotspot()