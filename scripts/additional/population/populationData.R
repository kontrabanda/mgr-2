library(raster)
library(sp)
library(maptools)
library(spatstat)
library(rgdal)

####################### Białystok
populationPoland <- shapefile("../data/additional/bialystok/population/PD_STAT_GRID_CELL_2011.shp")
populationPoland <- spTransform(populationPoland, CRS("+init=epsg:4326"))

bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
onlyBialystok <- aggregate(bialystok)

populationBialystok <- intersect(populationPoland, onlyBialystok)

plot(populationBialystok)

#writeOGR(populationBialystok, "../data/additional/bialystok/population-only-bialystok", "population_bialystok_grid_2011", driver="ESRI Shapefile")


populationBialystok <- shapefile('../data/additional/bialystok/population-only-bialystok/population_bialystok_grid_2011.shp')
crimes <- read.csv('../data/bialystok/crimes_bialystok.csv')

coordinates(crimes) =~ LNG+LAT
projection(crimes) = projection(populationBialystok)

joined = over(crimes, populationBialystok)

results <- data.frame(crimes, population = joined$TOT)
write.csv(results, file = '../data/bialystok/crimes_bialystok_with_population.csv')

####################### Bournemouth
bournemouthPopulation <- shapefile("../data/additional/bournemouth/population/E06000028.shp")
bournemouthPopulation <- spTransform(bournemouthPopulation, CRS("+init=epsg:4326"))

crimes <- read.csv('../data/bournemouth/crimes_bournemouth.csv')
coordinates(crimes) =~ Longitude+Latitude
projection(crimes) = projection(bournemouthPopulation)

joined = over(crimes, bournemouthPopulation)

results <- data.frame(crimes, population = joined$all_ages)
write.csv(results, file = '../data/bournemouth/crimes_bournemouth_with_population.csv')


