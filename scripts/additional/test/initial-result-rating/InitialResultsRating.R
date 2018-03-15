library(raster)
library(sp)
library(lubridate)
library(dplyr)

source(file = './const.R')
source(file = './data/bialystok/BialystokDataWithoutDuplicates.R')
source(file = './data/bournemouth/BournemouthDataWithoutDuplicates.R')

#source(file = './data/bournemouth/BournemouthData.R')


########## shoplifiting check (compare to bulgrary)

category <- 'Shoplifting'

dataClass <- BournemouthDataWithoutDuplicates()
shopliftingCategoryLabel <- dataClass$getData('Shoplifting')
shoplifiting <- shopliftingCategoryLabel[shopliftingCategoryLabel$label == 1, ]

bournemouth <- shapefile("../data/additional/boundries/bournemouth/Bournemouth.shp")
bournemouth <- spTransform(bournemouth, CRS("+init=epsg:4326"))
onlyBournemouth <- aggregate(bournemouth)

coordinates(shoplifiting) =~ lng+lat
projection(shoplifiting) = projection(bournemouth)

bulgraryCategoryLabel <- dataClass$getData('Burglary')
bulgrary <- bulgraryCategoryLabel[bulgraryCategoryLabel$label == 1, ]

coordinates(bulgrary) =~ lng+lat
projection(bulgrary) = projection(bournemouth)

length(bulgrary$label)
length(shoplifiting$label)

bulgraryUniquePoints <- nrow(unique(data.frame(bulgrary)[, c('lat', 'lng')]))
bulgraryUniquePoints
shoplifitingUniquePoints <- nrow(unique(data.frame(shoplifiting)[, c('lat', 'lng')]))
shoplifitingUniquePoints

plot(onlyBournemouth)
plot(bulgrary, col = 'blue', add = T)
plot(shoplifiting, col = 'red', add = T)

bulgraryInMonths <- data.frame(bulgrary) %>% group_by(month) %>% summarize(n = n())
shopliftingInMonths <- data.frame(shoplifiting) %>% group_by(month) %>% summarize(n = n())
