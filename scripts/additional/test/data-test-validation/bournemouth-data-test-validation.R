source(file = './data/bournemouth/BournemouthDataWithoutDuplicates.R')
source(file = './const.R')

dataSource <- BournemouthDataWithoutDuplicates()

data <- dataSource$rawData
data$month <- as.numeric(as.character(data$month))

years <- sort(as.numeric(as.character(unique(data$year))))
months <- sort(as.numeric(as.character(unique(data$month))))

#### crimes per year
crimesPerYear <- data.frame(year=years, crimesCount=NA)

for(singleYear in years) {
  crimesPerYear[crimesPerYear$year == singleYear, c('crimesCount')] <- nrow(data[data$year == singleYear, ])
}

#### crimes per month
monthsCount <- length(months)
yearsCount <- length(years)

crimesPerMonth <- data.frame(year=rep(years, each=monthsCount), month=rep(months, times=yearsCount), crimeCount = NA)

for(singleYear in years) {
  for(singleMonth in months) {
    crimesPerMonth[crimesPerMonth$year == singleYear & crimesPerMonth$month == singleMonth, c('crimeCount')] <- nrow(data[data$year == singleYear & data$month == singleMonth, ])
  }
}


