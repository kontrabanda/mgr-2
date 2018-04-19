ConstHotspot <- setRefClass(
  Class="ConstHotspot",
  fields=list(
    resultPath="character",
    bialystokHotSpotPath="character",
    
    poiCategories="character"
  ),
  methods = list(
    initialize = function(classificatorName = '') {
      resultPath <<- '../results'
      
      bialystokHotSpotPath <<- '../data/points-in-hotspots/bialystok'
      
      poiCategories <<- c('shop', 'communication', 'money', 'education', 'security', 
                          'public', 'health', 'food', 'culture', 'turist', 
                          'services', 'sport', 'other')
    }
  )
)

const <- ConstHotspot()