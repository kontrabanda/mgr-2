source(file="./util.R")
source(file="./data/BialystokPOIDistData.R")

bialystokData <- BialystokPOIDistData()
data <- bialystokData$rawData

##################

monthInterval <- 6

date <- data.frame(month = as.numeric(as.character(data$month)), year = as.numeric(as.character(data$year)))

firstYear <- min(unique(date$year))
lastYear <- max(unique(date$year))
monthCount <- 12

toMonths <- 1:(monthCount/monthInterval) * monthInterval

years <- c()
months <- c()

for(year in firstYear:lastYear) {
  for(i in toMonths) {
    years <- c(years, year)
    months <- c(months, i)
  }
}

cuttingPoints <- data.frame(year=years, month=months)
cuttingPoints <- cuttingPoints[cuttingPoints$year > 2010, ]
################
#wejściowy
currIndex <- 2

currPoint <- cuttingPoints[currIndex, ]
nextPoint <- cuttingPoints[currIndex + 1, ]

trainIndexes <- date$year < currPoint$year | (date$year == currPoint$year & date$month < currPoint$month)

testIndexes <- (date$year > currPoint$year | (date$year == currPoint$year & date$month > currPoint$month)) &
               (date$year < nextPoint$year | (date$year == nextPoint$year & date$month < nextPoint$month))

#testIndexes <- (date$year >= currPoint$year & date$year <= nextPoint$year) & (date$month >= currPoint$month & date$month <= nextPoint$month)
sum(trainIndexes)
sum(testIndexes)
