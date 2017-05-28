
# User Config

sql_dsn = "VotersMSSQL"

projectPath = "E:/git/VotersOKC"
dir_voter_registration = "data/large-data/voter-registration/CTYSW_VR_20170518095903"
dir_voter_history = "data/large-data/voter-history/CTYSW_VH_20170518095851"
dir_census_data = "data/large-data/census-data"

# Run Options

first_run = FALSE
load_registered_voters = FALSE
build_okc_voters = FALSE
build_precinct_table = FALSE
build_precinct_shapefile = FALSE
build_census_tracts_shapefile = FALSE #Warning - the raster intersect failed on a few polygos, and ArcView Geoprocessing was used instead
load_census_tracts_table = FALSE

if (first_run)
{
  load_registered_voters = TRUE
  build_okc_voters = TRUE
}

# Enviroment Setup

setwd(projectPath)

file_CTY09_vr = paste(dir_voter_registration, "/CTY09_vr.csv", sep="")
file_CTY14_vr = paste(dir_voter_registration, "/CTY14_vr.csv", sep="")
file_CTY55_vr = paste(dir_voter_registration, "/CTY55_vr.csv", sep="")
file_CTY63_vr = paste(dir_voter_registration, "/CTY63_vr.csv", sep="")

file_CTY09_vh = paste(dir_voter_registration, "/CTY09_vh.csv", sep="")
file_CTY14_vh = paste(dir_voter_registration, "/CTY14_vh.csv", sep="")
file_CTY55_vh = paste(dir_voter_registration, "/CTY55_vh.csv", sep="")
file_CTY63_vh = paste(dir_voter_registration, "/CTY63_vh.csv", sep="")

file_ca_precincts_shp = "data/shapefiles/canadian-precincts"
file_cl_precincts_shp = "data/shapefiles/cleveland-precincts"
file_ok_precincts_shp = "data/shapefiles/oklahoma-precincts"
file_po_precincts_shp = "data/shapefiles/pottawatomie-precincts"

file_ca_precincts_lyr = "pct2010_017"
file_cl_precincts_lyr = "pct2010_027"
file_ok_precincts_lyr = "pct2010_109"
file_po_precincts_lyr = "pct2010_125"

file_okc_wards_kmz = "data/shapefiles/city-council-wards/CityCouncilWards.kmz"
file_okc_wards_kml = "data/shapefiles/city-council-wards/CityCouncilWards.kml"
file_okc_wards_lyr = "City Council Wards"

file_okc_precincts_csv = "output/okc-precincts/okc-precincts.csv"
file_okc_precincts_shp = "output/okc-precincts"
file_okc_precincts_kml = "output/okc-precincts/OKC_Precincts.kml"
file_okc_precincts_lyr = "OKC_Precincts"

file_voters_basic_summary_csv = "output/registered-voters/basic-summary.csv"

file_create_okcvoters_sql = "sql/okc-voters/create-OkcVoters-table.sql"
file_load_okcvoters_sql = "sql/okc-voters/load-OkcVoters-table.sql"
file_load_okcprecincts_sql = "sql/okc-voters/load-OkcPrecincts-table.sql"

file_census_tracts_shp = "output/census-data/tract/census-tracts"
file_census_tracts_lyr = "census-tracts"

file_okc_census_tracts_shp = "output/census-data/tract/okc-census-tracts"
file_okc_census_tracts_kml = "output/census-data/tract/okc-census-tracts/OKC_Census_Tracts.kml"
file_okc_census_tracts_lyr = "OKC_Census_Tracts"

# Process Raw Data Into Tidy Data

source(paste(projectPath, "/src/load-registered-voters.R", sep=""))
source(paste(projectPath, "/src/create-census-tract-shapefile.R", sep=""))

if (load_registered_voters)
{
  cat("Loading Registered Voters")
  load.registered.voters()
}

if (build_okc_voters)
{
  cat("Building OkcVoters")
  build.okc.voters()
}

if (build_precinct_table)
{
  cat("Building Precincts Table")
  build.precinct.summary()
}

if (build_precinct_shapefile)
{
  cat("Building Precinct Shapefile")
  create.precincts.shapefile()
}

if (build_census_tracts_shapefile)
{
  cat("Building Census Tracts Shapefile")
  create.census.tracts.shapefile()
}

if (load_census_tracts_table)
{
  cat("Loading Census Tracts Table")
  load.census.tracts()
}













