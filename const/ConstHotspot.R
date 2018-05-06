ConstHotspot <- setRefClass(
  Class="ConstHotspot",
  fields=list(
    resultPath="character",
    bialystokHotSpotPath="character",
    bournemouthHotSpotPath="character",
    bialystokSWDHotSpotPath="character",
    olsztynSWDHotSpotPath="character",
    randomHotSpotPath="character",
    
    bialystokGridHotSpotPath="character",
    bournemouthGridHotSpotPath="character",
    bialystokSWDGridHotSpotPath="character",
    olsztynSWDGridHotSpotPath="character",
    randomGridHotSpotPath="character",
    
    poiCategories="character"
  ),
  methods = list(
    initialize = function(classificatorName = '') {
      resultPath <<- '../results'
      
      bialystokHotSpotPath <<- '../data/points-in-hotspots/bialystok'
      bournemouthHotSpotPath <<- '../data/points-in-hotspots/bournemouth'
      bialystokSWDHotSpotPath <<- '../data/points-in-hotspots/bialystokSWD'
      olsztynSWDHotSpotPath <<- '../data/points-in-hotspots/olsztynSWD'
      randomHotSpotPath <<- '../data/points-in-hotspots/random'
      
      bialystokGridHotSpotPath <<- '../data/hotspot-grid/bialystok'
      bournemouthGridHotSpotPath <<- '../data/hotspot-grid/bournemouth'
      bialystokSWDGridHotSpotPath <<- '../data/hotspot-grid/bialystokSWD'
      olsztynSWDGridHotSpotPath <<- '../data/hotspot-grid/olsztynSWD'
      randomGridHotSpotPath <<- '../data/hotspot-grid/random'
      
      poiCategories <<- c('shop', 'communication', 'money', 'education', 'security', 
                          'public', 'health', 'food', 'culture', 'turist', 
                          'services', 'sport', 'other')
    }
  )
)

const <- ConstHotspot()