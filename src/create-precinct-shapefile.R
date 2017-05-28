library(rgeos)
library(rgdal)
library(raster)
library(maptools)

create.precincts.shapefile = function()
{
  
  # County-level precinct shapes
  shp_cnty_ca = readOGR(file_ca_precincts_shp, file_ca_precincts_lyr)
  shp_cnty_cl = readOGR(file_cl_precincts_shp, file_cl_precincts_lyr)
  shp_cnty_ok = readOGR(file_ok_precincts_shp, file_ok_precincts_lyr)
  shp_cnty_po = readOGR(file_po_precincts_shp, file_po_precincts_lyr)
  
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
  csv_okc_precincts = read.csv(file_okc_precincts_csv)
  shp_cnty_all4 = shp_cnty_all4[ shp_cnty_all4$Precinct %in% csv_okc_precincts$precinct, ]
  
  # filter precincts with geographic interection of city boundaries
  shp_okc_borders = readOGR(file_okc_wards_kml, file_okc_wards_lyr)
  shp_okc_precincts = intersect(shp_cnty_all4, shp_okc_borders)
  
  # load and join some precinct-level summary data (from registered voter database)
  csv_precinct_summary = read.csv(file_voters_basic_summary_csv)
  shp_okc_precincts = merge(shp_okc_precincts, csv_precinct_summary, by="Precinct", all.x=TRUE)
  
  shp_okc_precincts$PopDensity = shp_okc_precincts$RegisteredVoters / shp_okc_precincts$SHAPE_Area
  
  # rename and reorder some joined properties (intentionally dropping 16th column)
  names(shp_okc_precincts)[15] = "Ward"
  shp_okc_precincts = shp_okc_precincts[,c(1:3,15,11,12,17:26,4:10,13,14)]
  
  writeOGR(shp_okc_precincts, file_okc_precincts_shp, file_okc_precincts_lyr, driver="ESRI Shapefile")
  writeOGR(shp_okc_precincts, file_okc_precincts_kml, file_okc_precincts_lyr, driver="KML")

}








