library(rgeos)
library(rgdal)
library(raster)
library(maptools)

create.census.tracts.shapefile = function()
{
  shp_okc_precincts = readOGR(file_okc_precincts_shp, file_okc_precincts_lyr)
  shp_census_tracts = readOGR(file_census_tracts_shp, file_census_tracts_lyr)
  
  shp_okc_census_tracts = intersect(shp_okc_precincts, shp_census_tracts)
  
  writeOGR(shp_okc_census_tracts, file_okc_census_tracts_shp, file_okc_census_tracts_lyr, driver="ESRI Shapefile")
  writeOGR(shp_okc_census_tracts, file_okc_census_tracts_kml, file_okc_census_tracts_lyr, driver="KML")
}

load.census.tracts = function()
{
  shp_okc_census_tracts = readOGR(file_okc_census_tracts_shp, file_okc_census_tracts_lyr)
  
  OkcCensusTracts = data.frame(
    GEOID = shp_okc_census_tracts$GEOID,
    GEOID_Data = shp_okc_census_tracts$GEOID_Data,
    CensusTract = shp_okc_census_tracts$TRACTCE,
    Precinct = shp_okc_census_tracts$Precnct,
    CountyText = shp_okc_census_tracts$CntyTxt,
    Ward = shp_okc_census_tracts$Ward,
    StateHouse = shp_okc_census_tracts$St_hous,
    StateSenate = shp_okc_census_tracts$St_sent
  )
  
  conn = odbcConnect(sql_dsn)
  sqlDrop(conn, "OkcCensusTracts", error=FALSE)
  sqlSave(conn, OkcCensusTracts, tablename="OkcCensusTracts", rownames=FALSE)
  odbcClose(conn)
}