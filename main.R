source(file="./const.R")

source(file="./data/BialystokData.R")
source(file="./data/BostonData.R")
source(file="./data/BournemouthData.R")

source(file="./model/LogisticRegressionModel.R")
source(file="./model/KNNModel.R")
source(file="./model/NaiveBayesModel.R")
source(file="./model/RandomForestModel.R")
source(file="./model/SVMModel.R")

source(file="./strategy/CrossValidation.R")
source(file="./rating/BinaryRating.R")

bialystokData <- BialystokData()


crossValidation <- CrossValidation(bialystokData, NaiveBayesModel)
crossValidation$crossValidation()

binaryRating <- BinaryRating(bialystokData, NaiveBayesModel)
binaryRating$computeRating()

cars <- c("FORD", "GM")
price  <- list( c(1000, 2000, 3000),  c(2000, 500, 1000))
myDF <- data.frame(cars=cars, price=cbind(price))

library("dplyr")   

fun <- function(arg) {
  list(unique(arg))
}

temp <- bialystokData$rawData %>% group_by(lat, lng, day, month, year) %>% summarize(category = fun(category))

temp2 <- mapply(`%in%`, 'CHU', temp$category)
temp3 <- sapply(temp$category, function(x) 'CHU' %in% x)

temp100 <- as.factor(ifelse(temp3, 1, 0))

