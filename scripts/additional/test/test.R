library(raster)
library(sp)
library(lubridate)

crime <- read.csv("../data/test/zdarzenia.csv")
# 615 961

crime$geo_lat <- as.numeric(as.character(crime$geo_lat))
crime$geo_long <- as.numeric(as.character(crime$geo_long))

crime <- crime[!is.na(crime$geo_lat)&!is.na(crime$geo_long), ]
# 549972

### problem with reverse coordinates
geoLat <- ifelse(crime$geo_lat > 50, crime$geo_lat, crime$geo_long)
geoLong <- ifelse(crime$geo_long < 30, crime$geo_long, crime$geo_lat)

crime$geo_lat <- geoLat
crime$geo_long <- geoLong

bialystok <- shapefile("../data/additional/boundries/bialystok/bialystok.shp")
bialystok <- spTransform(bialystok, CRS("+init=epsg:4326"))
onlyBialystok <- aggregate(bialystok)

coordinates(crime) =~ geo_long+geo_lat
projection(crime) = projection(bialystok)

crimeBialystok <- intersect(crime, onlyBialystok)
crimeBialystokDF <- data.frame(crimeBialystok)

write.csv(file =  "../data/test/zdarzenia_res_bialystok.csv", x = crimeBialystokDF)

unique(crimeBialystokDF$powiat)
table(crimeBialystokDF$powiat)

crimeDF <- data.frame(crime)

yearBiałystok <- year(ymd_hms(crime$data))
table(yearBiałystok)

table(crimeDF$rodzaj)

## olsztyna nie jest wzięty do analizy (brak przestępstw na jego terenie)
olsztyn <- shapefile("../data/additional/boundries/olsztyn/olsztyn.shp")
olsztyn <- spTransform(olsztyn, CRS("+init=epsg:4326"))
onlyOlsztyn <- aggregate(olsztyn)

crimeOlsztyn <- intersect(crime, onlyOlsztyn)
crimeOlsztynDF <- data.frame(crimeOlsztyn)

write.csv(file =  "../data/test/zdarzenia_res_olsztyn.csv", x = crimeOlsztynDF)

crimeBialystokDF <- read.csv("../data/test/zdarzenia_res_bialystok.csv")
unique(crimeBialystokDF$src)

rsow <- crimeBialystokDF[crimeBialystokDF$src == 'RSOW', ]
unique(rsow$rodzaj)
table(rsow$rodzaj)

