source(file="./data/BialystokCrimeDataClass.R")
source(file="./data/BostonCrimeDataClass.R")
source(file="./data/BournemouthCrimeDataClass.R")


bialystokCrimeDataClass <- BialystokCrimeDataClass()
categories <- bialystokCrimeDataClass$getClassificationCategories()
test <- bialystokCrimeDataClass$getData(categories[1])

rm(bialystokCrimeDataClass, categories, test)


bostonCrimeDataClass <- BostonCrimeDataClass()
categories <- bostonCrimeDataClass$getClassificationCategories()
test <- bostonCrimeDataClass$getData(categories[1])

rm(bostonCrimeDataClass, categories, test)


bournemouthCrimeDataClass <- BournemouthCrimeDataClass()
categories <- bournemouthCrimeDataClass$getClassificationCategories()
test <- bournemouthCrimeDataClass$getData(categories[1])

rm(bournemouthCrimeDataClass, categories, test)
