
source(file = './data/swd/BialystokSWDData.R')
source(file = './data/swd/OlsztynSWDData.R')
source(file = './const.R')

bialystokSWDData <- BialystokSWDData()
bialystokSWDData$extractData()

head(bialystokSWDData$rawData)
nrow(bialystokSWDData$rawData)

olsztynSWDData <- OlsztynSWDData()
olsztynSWDData$extractData()

head(olsztynSWDData$rawData)
nrow(olsztynSWDData$rawData)
