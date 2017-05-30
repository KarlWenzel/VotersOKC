###############
# User Config #
###############

sql_dsn = "VotersMSSQL"
projectPath = "E:/git/VotersOKC"
dir_voter_registration = "data/large-data/voter-registration/CTYSW_VR_20170518095903"
dir_voter_history = "data/large-data/voter-history/CTYSW_VH_20170518095851"
dir_census_data = "data/large-data/census-data"


###############
# Run Options #
###############

load_registered_voters_tables = FALSE
load_okc_voters_table = FALSE

load_voter_history_tables = FALSE
load_okc_voter_history_table = FALSE

build_precincts_shapefile = FALSE
load_precincts_table = FALSE #WARNING: Before running this, make sure that SquareFt area was calcuated on the shapefile

build_okc_precincts_shapefile = FALSE
load_okc_precincts_table = FALSE #WARNING: Before running this, make sure that SquareFt area was calcuated on the shapefile

load_census_tracts_table = FALSE # WARNING: file_census_tracts_shp must be exported from .GDB; calculate SquareFt on this shapefile first
load_okc_census_tracts_table = FALSE #wARNING: use ArcMap Geoprocessing to intersect with OKC_Precinct.shp, and create SquareFt

load_census_metadata_table = FALSE

# This next part is heavily dependent on ArcMap.  Multiple SHPs were exported from joining Census GDB data to the OKC_Census_Tract layer
# Warning - Joining to the OKC_Census_Tract layer gives us the right number of rows, but the wrong SquareFt field - ensure this field is omitted

load_census_age_and_sex_table = TRUE


####################
# Enviroment Setup #
####################

setwd(projectPath)

file_CTY09_vr = paste(dir_voter_registration, "/CTY09_vr.csv", sep="")
file_CTY14_vr = paste(dir_voter_registration, "/CTY14_vr.csv", sep="")
file_CTY55_vr = paste(dir_voter_registration, "/CTY55_vr.csv", sep="")
file_CTY63_vr = paste(dir_voter_registration, "/CTY63_vr.csv", sep="")

file_CTY09_vh = paste(dir_voter_history, "/CTY09_vh.csv", sep="")
file_CTY14_vh = paste(dir_voter_history, "/CTY14_vh.csv", sep="")
file_CTY55_vh = paste(dir_voter_history, "/CTY55_vh.csv", sep="")
file_CTY63_vh = paste(dir_voter_history, "/CTY63_vh.csv", sep="")

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

file_precincts_shp = "output/precincts"
file_precincts_kml = "output/precincts/Precincts.kml"
file_precincts_lyr = "Precincts"

file_okc_precincts_shp = "output/okc-precincts"
file_okc_precincts_kml = "output/okc-precincts/OKC_Precincts.kml"
file_okc_precincts_lyr = "OKC_Precincts"

file_census_tract_metadata_csv = "data/TRACT_METADATA_2015.txt"
file_census_countyfp_csv = "data/census-countyfp-codes-oklahoma.txt"
file_census_tracts_shp = "output/census-data/tract/census-tracts"
file_census_tracts_lyr = "census-tracts"

file_okc_census_tracts_shp = "output/census-data/tract/okc-census-tracts"
file_okc_census_tracts_kml = "output/census-data/tract/okc-census-tracts/OKC_Census_Tracts.kml"
file_okc_census_tracts_lyr = "OKC_Census_Tracts"

file_okc_census_age_and_sex_shp = "output/census-data/tract/age-and-sex"
file_okc_census_age_and_sex_lyr = "age-and-sex"

####################
# Process Raw Data #
####################

source(paste(projectPath, "/src/registered-voters.R", sep=""))

if (load_registered_voters_tables)
{
  cat("Loading Raw Registered Voters\n")
  load.registered.voters.tables()
}

if (load_okc_voters_table)
{
  cat("Loading OkcVoters\n")
  load.okc.voters.table()
}

if (load_voter_history_tables)
{
  cat("Loading Raw Voter History\n")
  load.voter.history.tables()
}

if (load_okc_voter_history_table)
{
  cat("Loading OKCVoterHistory\n")
  load.okc.history.table()
}

source(paste(projectPath, "/src/precincts.R", sep=""))

if (build_precincts_shapefile)
{
  cat("Building Precinct Shapefile\n")
  build.precincts.shapefile()
}

if (load_precincts_table)
{
  cat("Loading Precincts Table\n")
  load.precincts.table()
}

if (build_okc_precincts_shapefile)
{
  cat("Building OKC Precinct Shapefile\n")
  build.okc.precincts.shapefile()
}

if (load_okc_precincts_table)
{
  cat("Loading OKC Precincts Table\n")
  load.okc.precincts.table()
}

source(paste(projectPath, "/src/census-tracts.R", sep=""))

if (load_census_tracts_table)
{
  cat("Loading Census Tracts Table\n")
  load.census.tracts.table()
}

if (load_okc_census_tracts_table)
{
  cat("Loading Census Tracts Table\n")
  load.okc.census.tracts.table()
}

if (load_census_metadata_table)
{
  cat("Loading Census Metadata Table\n")
  load.census.metadata.table()
}

if (load_census_age_and_sex_table)
{
  cat("Loading Census Age and Sex")
  load.census.age.and.sex()
}









