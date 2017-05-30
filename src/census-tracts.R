library(rgeos)
library(rgdal)
library(raster)
library(maptools)

load.census.tracts.table = function()
{
  countyfp = read.csv(file_census_countyfp_csv, col.names=c("State", "STATEFP2", "COUNTYFP", "County", "H1"))
  countyfp = countyfp[ countyfp$County %in% c("Canadian County", "Cleveland County", "Oklahoma County", "Pottawatomie County"), ]
  
  shp_census_tracts = readOGR(file_census_tracts_shp, file_census_tracts_lyr)
  shp_census_tracts = shp_census_tracts[ shp_census_tracts$COUNTYFP %in% countyfp$COUNTYFP, ]
  shp_census_tracts = merge(shp_census_tracts, countyfp, by="COUNTYFP", all.x=TRUE)
  
  CensusTracts = data.frame(
    GEOID = shp_census_tracts$GEOID,
    GEOID_Data = shp_census_tracts$GEOID_Data,
    CensusTract = shp_census_tracts$TRACTCE,
    Name = shp_census_tracts$NAME,
    StateFP = shp_census_tracts$STATEFP,
    CountyFP = shp_census_tracts$COUNTYFP,
    County = shp_census_tracts$County,
    SquareFt = shp_census_tracts$SquareFt
  )
  
  conn = odbcConnect(sql_dsn)
  sqlDrop(conn, "CensusTracts", error=FALSE)
  sqlSave(conn, CensusTracts, tablename="CensusTracts", rownames=FALSE, append=TRUE)
  odbcClose(conn)
}


load.okc.census.tracts.table = function()
{
  shp_okc_census_tracts = readOGR(file_okc_census_tracts_shp, file_okc_census_tracts_lyr)
  
  OkcCensusTracts = data.frame(
    GEOID = shp_okc_census_tracts$GEOID,
    CensusTract = shp_okc_census_tracts$TRACTCE,
    Precinct = shp_okc_census_tracts$Precnct,
    SquareFt = shp_okc_census_tracts$SquareFt
  )
  
  conn = odbcConnect(sql_dsn)
  sqlQuery(conn, "DELETE * FROM OkcCensusTracts")
  sqlSave(conn, OkcCensusTracts, tablename="OkcCensusTracts", rownames=TRUE, append=TRUE)
  odbcClose(conn)
}

load.census.metadata.table = function()
{
  CensusMetadata <- read.table(file_census_tract_metadata_csv, sep="\t", header=TRUE)
  CensusMetadata$CensusYear = 2015
  CensusMetadata = CensusMetadata[, c(3,1,2)]
  
  conn = odbcConnect(sql_dsn)
  sqlQuery(conn, "DELETE * FROM CensusMetadata")
  sqlSave(conn, CensusMetadata, tablename="CensusMetadata", rownames=FALSE, append=TRUE)
  odbcClose(conn)
}

load.census.age.and.sex = function()
{
  #shp_okc_census_age_and_sex = readOGR(file_okc_census_age_and_sex_shp, file_okc_census_age_and_sex_lyr)
}




