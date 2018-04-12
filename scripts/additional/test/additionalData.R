library(raster)
library(sp)
library(latticeExtra)
library(RColorBrewer)
library(ggplot2)
library(maptools)
library(spatstat)
library(lubridate)
library(rgdal)

################## Bournemouth

## populacja dla bournemouth dla wieku dla podziału administracyjnego (110 dzielnic dla Bournemouth) -> liczba ludzi w danym wieku
population <- shapefile("../data/additional/bournemouth/population/E06000028.shp")

## miejsca zieleni dla bournemouth 217 poligonów
greenspace <- shapefile("../data/additional/bournemouth/greenspace/E06000028_Bournemouth_greenspacesite.shp")

## workplace -> dane trzeba połączyć z tabelą w innych plikach
workpalceZones <- shapefile("../data/additional/bournemouth/workplace/shapefiles/WPZONE.shp")

## energy -> punkty wraz z zurzyciem energii (gas/elektryczność) -> 3433 punkty
energy <- shapefile("../data/additional/bournemouth/energy/shapefiles/E06000028_Bournemouth_electricity.shp")

## house-prices -> z podziałem na 110 regionów (agregacja), dla różnych lat (1995-2015), są różne pliki dla różnych typów budynków (mediana ceny oraz ilość transakcji w danym roku)
housePrices <- shapefile("../data/additional/bournemouth/house-prices/shapefiles/E06000028_all.shp")

## deprivation -> jakiś indeks wyliczany przez władzę w GB -> ale dla mnie zbyt niejasny i nie skalowalny na inne miejsca, może być pochodną zdarzeń kryminalnych -> a tego chciałbym uniknąć
deprivation -> shapefile("../data/additional/bournemouth/deprivation/shapefiles/E06000028.shp")

## residence workplace -> sporo danych w formacie csv odnoszących się do miejsca pracy i miejsca zamieszkania oraz sposobów dojazdów

################## Białystok

## workplace -> dane trzeba połączyć z tabelą w innych plikach
populationPoland <- shapefile("../data/additional/bialystok/population/PD_STAT_GRID_CELL_2011.shp")
populationPoland <- spTransform(populationPoland, CRS("+init=epsg:4326"))

bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
onlyBialystok <- aggregate(bialystok)

populationBialystok <- intersect(populationPoland, onlyBialystok)

plot(populationBialystok)

#writeOGR(populationBialystok, "../data/additional/bialystok/population-only-bialystok", "population_bialystok_grid_2011", driver="ESRI Shapefile")

n <- sum(populationBialystok$TOT)

##### z Basecamp'a
imprezy <- read.csv("../data/additional/bialystok/basecamp/bialystok-imprezy.csv")
imprezy$DZIEN <- as.Date(imprezy$DZIEN)

imprezyYears <- year(as.Date(imprezy$DZIEN))
table(imprezyYears)

weather <- read.csv("../data/additional/bialystok/basecamp/bialystok-pogoda.csv")








