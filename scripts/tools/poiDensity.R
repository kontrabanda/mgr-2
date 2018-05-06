library(methods) # for Rscript

args = commandArgs(trailingOnly=TRUE)

cityName <- args[1]

type <- args[2]

if(type == 'all') {
  rs <- c(100, 200, 500)
  #rs <- c(200, 500)
  
  for(radius in rs) {
    r <- radius
    print(paste('Selected r = ', r, sep = ''))
    if(cityName == 'bialystok') {
      source(file = './scripts/additional/poi/bialystokPOIDensity.R')
    } else if(cityName == 'bournemouth') {
      source(file = './scripts/additional/poi/bournemouthPOIDensity.R')
    } else if(cityName == 'boston') {
      source(file = './scripts/additional/poi/bostonPOIDensity.R')
    } else {
      stop('No such dataset!')
    }
  }
  
} else {
  r <- as.numeric(type)
  
  if(is.na(r)) {
    stop('r not set')
  }
  
  if(cityName == 'bialystok') {
    source(file = './scripts/additional/poi/bialystokPOIDensity.R')
  } else if(cityName == 'bournemouth') {
    source(file = './scripts/additional/poi/bournemouthPOIDensity.R')
  } else if(cityName == 'boston') {
    source(file = './scripts/additional/poi/bostonPOIDensity.R')
  } else if(cityName == 'bialystokHotspot') {
    source(file = './scripts/additional/poi/hotspot-element/bialystokHotspotPOIWrapper.R')
  } else if(cityName == 'bournemouthHotspot') {
    source(file = './scripts/additional/poi/hotspot-element/bournemouthHotspotPOIWrapper.R')
  } else if(cityName == 'bialystokGrid') {
    source(file = './scripts/additional/poi/hotspot-grid/bialystokHotspotPOIWrapper.R')
  } else if(cityName == 'bournemouthGrid') {
    source(file = './scripts/additional/poi/hotspot-grid/bournemouthHotspotPOIWrapper.R')
  } else if(cityName == 'bialystokSWDGrid') {
    source(file = './scripts/additional/poi/hotspot-grid/bialystokSWDHotspotPOIWrapper.R')
  } else if(cityName == 'olsztynSWDGrid') {
    source(file = './scripts/additional/poi/hotspot-grid/olsztynSWDHotspotPOIWrapper.R')
  } else if(cityName == 'bialystokSWDEl') {
    source(file = './scripts/additional/poi/hotspot-element/bialystokSWDHotspotPOIWrapper.R')
  } else if(cityName == 'olsztynSWDEl') {
    source(file = './scripts/additional/poi/hotspot-element/olsztynSWDHotspotPOIWrapper.R')
  } else if(cityName == 'bialystokSWDOneGrid') {
    source(file = './scripts/additional/poi/hotspot-grid/bialystokSWDOnePOIWrapper.R')
  } else {
    stop('No such dataset!')
  }
}
