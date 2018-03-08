source(file = './data/bialystok/BialystokDataWithoutDuplicates.R')
source(file = './const.R')

dataSource <- BialystokDataWithoutDuplicates()

data <- dataSource$rawData
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

crimesPerMonth <- data.frame(year=rep(years, each=monthsCount), month=rep(months, times=yearsCount), crimesCount = NA)

for(singleYear in years) {
  for(singleMonth in months) {
    crimesPerMonth[crimesPerMonth$year == singleYear & crimesPerMonth$month == singleMonth, c('crimesCount')] <- nrow(data[data$year == singleYear & data$month == singleMonth, ])
  }
}

#### summary

## year
yearMean <- mean(crimesPerYear$crimesCount)
yearMean
yearMaxValue <- max(crimesPerYear$crimesCount)
yearMaxValue
yearMaxElement <- crimesPerYear[crimesPerYear$crimesCount == yearMaxValue,]
yearMaxElement
yearMinValue <- min(crimesPerYear$crimesCount)
yearMinValue
yearMinElement <- crimesPerYear[crimesPerYear$crimesCount == yearMinValue, ]
yearMinElement

topYearsWithCrimes <- crimesPerYear[order(crimesPerYear$crimesCount, decreasing=T), ]
topYearsWithCrimes
bottomYearsWithCrimes <- crimesPerYear[order(crimesPerYear$crimesCount, decreasing=F), ]
bottomYearsWithCrimes

## month
monthMean <- mean(crimesPerMonth$crimesCount)
monthMean
monthMaxValue <- max(crimesPerMonth$crimesCount)
monthMaxValue
monthMaxElement <- crimesPerMonth[crimesPerMonth$crimesCount == monthMaxValue,]
monthMaxElement
monthMinValue <- min(crimesPerMonth$crimesCount)
monthMinValue
monthMinElement <- crimesPerMonth[crimesPerMonth$crimesCount == monthMinValue, ]
monthMinElement

topMonthsWithCrimes <- crimesPerMonth[order(crimesPerMonth$crimesCount, decreasing=T), ]
topMonthsWithCrimes[1:50,]
bottomMonthsWithCrimes <- crimesPerMonth[order(crimesPerMonth$crimesCount, decreasing=F), ]
bottomMonthsWithCrimes[1:50,]


write.csv(file = "../data/additional/analysis/bialystok_crimes_per_year.csv", x = crimesPerYear)
write.csv(file = "../data/additional/analysis/bialystok_crimes_per_month.csv", x = crimesPerMonth)

