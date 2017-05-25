library(rgeos)
library(rgdal)
library(raster)
library(maptools)

projectPath = "E:/git/VotersOKC"

# County-level precinct shapes
shp_cnty_ca = readOGR(paste(projectPath, "/shapefiles/OKC_Precincts/Canadian_precinct", sep=""), "pct2010_017")
shp_cnty_cl = readOGR(paste(projectPath, "/shapefiles/OKC_Precincts/Cleveland_precinct", sep=""), "pct2010_027")
shp_cnty_ok = readOGR(paste(projectPath, "/shapefiles/OKC_Precincts/Oklahoma_precinct", sep=""), "pct2010_109")
shp_cnty_po = readOGR(paste(projectPath, "/shapefiles/OKC_Precincts/Pottawatomie_precinct", sep=""), "pct2010_125")

shp_cnty_ca$Precinct =  90000 + as.numeric(as.character(shp_cnty_ca$Precinct))
shp_cnty_cl$Precinct = 140000 + as.numeric(as.character(shp_cnty_cl$Precinct))
shp_cnty_ok$Precinct = 550000 + as.numeric(as.character(shp_cnty_ok$Precinct))
shp_cnty_po$Precinct = 630000 + as.numeric(as.character(shp_cnty_po$Precinct))

shp_cnty_ca$CountyText = "Canadian"
shp_cnty_cl$CountyText = "Cleveland"
shp_cnty_ok$CountyText = "Oklahoma"
shp_cnty_po$CountyText = "Pottawatomie"

# need to reorder and rename a column in the Oklahoma county shapefile to accomodate the following rbind
shp_cnty_ok = shp_cnty_ok[,c(1,2,3,4,9,5,6,7,8,10,11,12,13,14)]
names(shp_cnty_ok)[5] = "SHAPE_Area"

# merge and reorder columns
shp_cnty_all4 = rbind(shp_cnty_ca, shp_cnty_cl, shp_cnty_ok, shp_cnty_po, makeUniqueIDs = TRUE)
shp_cnty_all4 = shp_cnty_all4[,c(1,6,14,2,3,4,5,7,8,9,10,11,12,13)]

# filter precincts with whitelist (generated from a query of voter registration data)
csv_okc_precincts = read.csv(paste(projectPath, "/reference-data/OKC-Precincts.csv", sep=""))
shp_cnty_all4 = shp_cnty_all4[ shp_cnty_all4$Precinct %in% csv_okc_precincts$precinct, ]

# filter precincts with geographic interection of city boundaries
shp_okc_borders = readOGR(paste(projectPath, "/shapefiles/OKC_Precincts/CityCouncilWards/CityCouncilWards.kml", sep=""), "City Council Wards")
shp_okc_precincts = intersect(shp_cnty_all4, shp_okc_borders)

# load and join some precinct-level summary data (from registered voter database)
csv_precinct_summary = read.csv(paste(projectPath, "/registered-voters/basic-summary.csv", sep=""))
shp_okc_precincts = merge(shp_okc_precincts, csv_precinct_summary, by="Precinct", all.x=TRUE)

# rename and reorder some joined properties (intentionally dropping 16th column)
names(shp_okc_precincts)[15] = "Ward"
shp_okc_precincts = shp_okc_precincts[,c(1:3,15,11,12,17:25,4:10,13,14)]

writeOGR(shp_okc_precincts, paste(projectPath, "/shapefiles/OKC_Precincts", sep=""), "OKC_Precincts", driver="ESRI Shapefile")
writeOGR(shp_okc_precincts, paste(projectPath, "/shapefiles/OKC_Precincts/OKC_Precincts.kml", sep=""), "OKC_Precincts", driver="KML")

plot(shp_okc_precincts)







