library(lubridate)
library(dplyr)

weather <- read.csv('../data/additional/bialystok/basecamp/bialystok-pogoda.csv')
weather <- weather[, 1:3] 


bialystokDate <- as.POSIXct(weather$Czas, format = '%Y-%m-%d %H:%M')

weather$day <- day(bialystokDate)
weather$month <- month(bialystokDate)
weather$year <- year(bialystokDate)
weather$hour <- hour(bialystokDate)

weather$temp <- weather$Bialystok.temp
weather$pogoda <- weather$Bialystok.pogoda


weather <- weather[, c('year', 'month', 'day', 'hour', 'pogoda', 'temp')]

weather$partOfDay <- ifelse(weather$hour >= 20 | weather$hour < 8, 'night', 'day')



groupTempDay <- function(temp, partOfDay) {
  filtredTemp <- temp[partOfDay == 'day']
  mean(filtredTemp)
}

groupTempNight <- function(temp, partOfDay) {
  filtredTemp <- temp[partOfDay == 'night']
  mean(filtredTemp)
}

groupWeatherDay <- function(hour, pogoda) {
  pogoda[hour == 12]
}

groupWeatherNight <- function(hour, pogoda) {
  pogoda[hour == 12]
}

weatherGrouped <- weather %>% group_by(year, month, day, year) %>% 
  summarize(tempDay = groupTempDay(temp, partOfDay), 
            tempNight = groupTempNight(temp, partOfDay), 
            weatherDay = groupWeatherDay(hour, pogoda),
            weatherNight = groupWeatherNight(hour, pogoda))

weatherGrouped$year <- as.integer(weatherGrouped$year)
weatherGrouped$month <- as.integer(weatherGrouped$month)
weatherGrouped$day <- as.integer(weatherGrouped$day)

crimes <- read.csv('../data/bialystok/crimes_bialystok.csv')

crimeDate <- as.Date(crimes$DATA, "%y/%m/%d")

crimes$day <- as.integer(day(crimeDate))
crimes$month <- as.integer(month(crimeDate))
crimes$year <- as.integer(year(crimeDate))

crimes$tempDay <- NA
crimes$tempNight <- NA
crimes$weatherDay <- NA
crimes$weatherNight <- NA

crimes <- crimes[crimes$year >= 2013, ]

print(Sys.time())
for(i in 1:nrow(crimes)) {
  singleCrime <- crimes[i, ]
  weatherForCrime <- weatherGrouped[weatherGrouped$year == singleCrime$year & weatherGrouped$month == singleCrime$month & weatherGrouped$day == singleCrime$day,]
  if(nrow(weatherForCrime) != 0) {
    crimes[i, ]$tempDay <- weatherForCrime$tempDay
    crimes[i, ]$tempNight <- weatherForCrime$tempNight
    crimes[i, ]$weatherDay <- as.character(weatherForCrime$weatherDay)
    crimes[i, ]$weatherNight <- as.character(weatherForCrime$weatherNight)
  }
}
print(Sys.time())

result <- crimes[!is.na(crimes$tempDay) & !is.na(crimes$tempNight) & !is.na(crimes$weatherDay) & !is.na(crimes$weatherNight), ]

write.csv(result, file = '../data/bialystok/crimes_with_weather.csv')
