library(rgeos)
library(rgdal)
library(raster)
library(maptools)

projectPath = "E:/git/VotersOKC"

shpW = readOGR("E:/git/VotersOKC/shapefiles/DataOKC/wards.geojson", "OGRGeoJSON", driver = "GeoJSON")