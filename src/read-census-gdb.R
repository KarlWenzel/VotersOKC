library(rgeos)
library(rgdal)
library(raster)
library(maptools)


censusFile = "E:/git/VotersOKC/shapefiles/ACS_2015_5YR_BG_40.gdb/ACS_2015_5YR_BG_40_OKLAHOMA.gdb"

# Get Layer Names
# orgListLayers(censusFile)

data = readOGR(dsn=censusFile, layer="ACS_2015_5YR_BG_40_OKLAHOMA")
