library(raster)
library(sp)

dorsetLandPoiShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_landuse_a_free_1.shp")
# polygon (pola, bazy wojskowe, wrzosowiska)
names <- data.frame(unique(dorsetLandPoiShape@data$fclass))

dorsetNaturePoiShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_natural_a_free_1.shp")
# polygon (plaże i klify)
names <- data.frame(unique(dorsetNaturePoiShape@data$fclass))

dorsetPlacesPoiShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_places_a_free_1.shp")
# polygon (wioski, farmy, miasta itp)
names <- data.frame(unique(dorsetPlacesPoiShape@data$fclass))

dorsetChurchesPoiShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_pofw_free_1.shp")
# points (katolickie, protestanckie, muzułmańskie itp)
names <- data.frame(unique(dorsetPlacesPoiShape@data$fclass))

dorsetBuildingsPoiShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_buildings_a_free_1.shp")
# polygon (budynki wraz z typami -> 88 ale trzeba będzie wybrać najlepsze)
names <- data.frame(unique(dorsetBuildingsPoiShape@data$type))

dorsetPoiShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_pois_free_1.shp")
# points (punkty poi 5102)
names <- data.frame(unique(dorsetBuildingsPoiShape@data$fclass))

dorsetTransportShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_transport_a_free_1.shp")
# polygon (stacje transportu)
names <- data.frame(unique(dorsetTransportShape@data$fclass))

dorsetRailwaysShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_railways_free_1.shp")
# lines (sieć kolejowa)
names <- data.frame(unique(dorsetRailwaysShape@data$fclass))

dorsetRoadsShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_roads_free_1.shp")
# lines (sieć drogowa)
names <- data.frame(unique(dorsetRoadsShape@data$fclass))

dorsetTrafficShape <- shapefile("../../../dodatkowe/poi/osm/dorset/dorset-latest-free.shp/gis.osm_traffic_a_free_1.shp")
# polygon (budynki/miejsca powiązane z transportem -> parkingi, stacje benzynowe itp)
names <- data.frame(unique(dorsetTrafficShape@data$fclass))

# oprócz tego jeszcze drogi wodne i zbiorniki wodne
