
path <- '../data/points-in-hotspots/bournemouth/'

getCategoriesFromPath <- function(path) {
  filesNames <- list.files(path = path, pattern = '*.csv')
  result <- gsub('.{4}$', '', filesNames)
  result
}

categories <- getCategoriesFromPath(path)

for(singleCategory in categories) {
  print(paste('Processing', singleCategory))
  categoryName <<- singleCategory
  source(file = './scripts/additional/poi/hotspot-element/bournemouthHotspotPOIDensity.R')
}
