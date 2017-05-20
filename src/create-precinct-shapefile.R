library(rgeos)
library(rgdal)
library(raster)
library(maptools)

projectPath = "E:/git/VotersOKC"

# All shapefiles are NAD83
shpCa = readOGR(paste(projectPath, "/shapefiles/Canadian_precinct", sep=""), "pct2010_017")
shpCl = readOGR(paste(projectPath, "/shapefiles/Cleveland_precinct", sep=""), "pct2010_027")
shpOk = readOGR(paste(projectPath, "/shapefiles/Oklahoma_precinct", sep=""), "pct2010_109")
shpPo = readOGR(paste(projectPath, "/shapefiles/Pottawatomie_precinct", sep=""), "pct2010_125")

shpCa$Precinct =  90000 + as.numeric(as.character(shpCa$Precinct))
shpCl$Precinct = 140000 + as.numeric(as.character(shpCl$Precinct))
shpOk$Precinct = 550000 + as.numeric(as.character(shpOk$Precinct))
shpPo$Precinct = 630000 + as.numeric(as.character(shpPo$Precinct))

shpCa$CountyText = "Canadian"
shpCl$CountyText = "Cleveland"
shpOk$CountyText = "Oklahoma"
shpPo$CountyText = "Pottawatomie"

# need to reorder and rename a column in the Oklahoma county shapefile to accomodate the following rbind
shpOk = shpOk[,c(1,2,3,4,9,5,6,7,8,10,11,12,13,14)]
names(shpOk)[5] = "SHAPE_Area"

shpAll4 = rbind(shpCa, shpCl, shpOk, shpPo, makeUniqueIDs = TRUE)
shpAll4 = shpAll4[,c(1,6,14,2,3,4,5,7,8,9,10,11,12,13)]
writeOGR(shpAll4, paste(projectPath, "/shapefiles/All4", sep=""), "precincts", driver="ESRI Shapefile")

shpMuni = readOGR(paste(projectPath, "/shapefiles/OKC_Municipal", sep=""), "OKC_Municipal")
shpCity = intersect(shpAll4, shpMuni)
writeOGR(shpCity, paste(projectPath, "/shapefiles/OKC_Precincts", sep=""), "OKC_Precincts", driver="ESRI Shapefile")
writeOGR(shpCity, paste(projectPath, "/shapefiles/OKC_Precincts/OKC_Precincts.kml", sep=""), "OKC_Precincts", driver="KML")










