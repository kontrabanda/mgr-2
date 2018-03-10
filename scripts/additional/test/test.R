source(file = './const.R')
source(file = './data/bialystok/BialystokDataWithoutDuplicates.R')
source(file = './data/bialystok/BialystokPOIDistData.R')
#source(file = './data/bialystok/BialystokPOIDensData.R')

bialystokData <- BialystokDataWithoutDuplicates()
bialystokData <- BialystokPOIDistData()

data <- bialystokData$rawData
unique(data$year)
unique(data$month)

temp <- data[is.na(data$year), ]

year2016 <- data[data$year == 2016, ]
unique(year2016$month)
