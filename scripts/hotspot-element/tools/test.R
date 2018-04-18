############################################## another kde library
source(file="./data/bialystok/BialystokDataWithoutDuplicates.R")
source(file="./const.R")

bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
city <- aggregate(bialystok)

plot(city)

crimesData <- BialystokDataWithoutDuplicates()
crimesData$extractData()

categoryData <- crimesData$getData('CHU')
onlyCategoryData <- categoryData[categoryData$label == 1, ][1:2]

coordinates(onlyCategoryData) =~ lng+lat
projection(onlyCategoryData) = projection(city)


library(spatialEco)

test <- sp.kde(x = onlyCategoryData, bw = 0.01, n = 1000, standardize = T)

plot(test)