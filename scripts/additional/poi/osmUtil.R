## PROJECTION
aeqdGlobal <- "+proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0"

crimes <- spTransform(crimes, aeqdGlobal)
city <- spTransform(city, aeqdGlobal)
poiShape <- spTransform(poiShape, aeqdGlobal)

poiCity <- intersect(poiShape, city)

## CATEGORIES
shop <- c('convenience', 'doityourself', 'kiosk', 'supermarket', 'car_dealership', 'clothes', 'beverages', 'shoe_shop', 
          'greengrocer', 'butcher', 'bakery', 'florist', 'beauty_shop', 'furniture_shop', 'chemist', 'bicycle_shop', 
          'vending_machine', 'mall', 'toy_shop', 'jeweller', 'computer_shop', 'bookshop', 'stationery', 'newsagent', 
          'vending_any', 'sports_shop', 'mobile_phone_shop', 'food_court', 'gift_shop', 'department_store', 'outdoor_shop')
communication <- c('post_box', 'telephone', 'post_office', 'comms_tower')
money <- c('atm', 'bank')
education <- c('school', 'library', 'university', 'college')
security <- c('fire_station', 'camera_surveillance', 'police', 'prison', 'courthouse', 'embassy')
public <- c('community_centre', 'chalet', 'recycling_metal', 'recycling', 'toilet', 'waste_basket', 'public_building', 'recycling_clothes', 
            'town_hall', 'water_well', 'bicycle_rental', 'recycling_glass', 'drinking_water', 'recycling_paper', 'graveyard')
health <- c('nursing_home', 'hospital', 'pharmacy', 'doctors', 'dentist', 'optician')
food <- c('cafe', 'biergarten', 'bar', 'restaurant', 'nightclub', 'fast_food', 'pub')
culture <- c('cinema', 'theatre', 'artwork', 'museum', 'arts_centre', 'archaeological')
turist <- c('observation_tower', 'car_rental', 'car_sharing', 'motel', 'fort', 'lighthouse', 'attraction', 'guesthouse', 'camp_site', 'travel_agent',
             'viewpoint', 'theme_park', 'playground', 'garden_centre', 
            'picnic_site', 'monument', 'fountain', 'memorial', 'hotel', 'zoo', 'hostel', 'park')
services <- c('veterinary', 'hairdresser', 'laundry', 'tourist_info', 'car_wash', 'kindergarten', 'vending_parking')
sport <- c('stadium', 'pitch', 'sports_centre', 'swimming_pool')
other <- c('ruins', 'bench', 'wayside_cross', 'wayside_shrine', 'tower', 'water_tower', 'shelter')

poiCity@data$fclass[poiCity@data$fclass %in% shop]  <- 'shop'
poiCity@data$fclass[poiCity@data$fclass %in% communication]  <- 'communication'
poiCity@data$fclass[poiCity@data$fclass %in% money]  <- 'money'
poiCity@data$fclass[poiCity@data$fclass %in% education]  <- 'education'
poiCity@data$fclass[poiCity@data$fclass %in% security]  <- 'security'
poiCity@data$fclass[poiCity@data$fclass %in% public]  <- 'public'
poiCity@data$fclass[poiCity@data$fclass %in% health]  <- 'health'
poiCity@data$fclass[poiCity@data$fclass %in% food]  <- 'food'
poiCity@data$fclass[poiCity@data$fclass %in% culture]  <- 'culture'
poiCity@data$fclass[poiCity@data$fclass %in% turist]  <- 'turist'
poiCity@data$fclass[poiCity@data$fclass %in% services]  <- 'services'
poiCity@data$fclass[poiCity@data$fclass %in% sport]  <- 'sport'
poiCity@data$fclass[poiCity@data$fclass %in% other]  <- 'other'
categories <- unique(poiCity@data$fclass)

## DISTANCE
calculateMinDistanceForCategory <- function(category) {
  elementsInCategory <- poiCity[poiCity@data$fclass==category, ]
  apply(gDistance(crimes, elementsInCategory, byid=TRUE), 2, min)
}

computeDistance <- function() {
  result <- data.frame(crimes)
  i <- 0
  for(singleCategory in categories) {
    i <- i + 1
    print(i)
    print(singleCategory)
    print(Sys.time())
    result[singleCategory] <- calculateMinDistanceForCategory(singleCategory)
  }
  result
}

## DENSITY
countElementsAroundPoint <- function(point, radius, elements) {
  circlePolygon <- drawCircleAroundPoint(point, radius)
  res <- over(elements, circlePolygon)
  sum(!is.na(res$name))
}

countElementsAroundPointForCategory <- function(category) {
  elementsInCategory <- poiCity[poiCity@data$fclass==category, ]
  res <- apply(pointsDensity, 1, function(x) countElementsAroundPoint(x, r, elementsInCategory))
  data.frame(res)
}

computeDensity <- function() {
  result <- data.frame(crimes)
  i <- 0
  for(singleCategory in categories) {
    i <- i + 1
    print(i)
    print(singleCategory)
    print(Sys.time())
    result[singleCategory] <- countElementsAroundPointForCategory(singleCategory)
  }
  result
}



