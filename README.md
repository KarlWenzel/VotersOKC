# VotersOKC

### Purpose

To provide basic voter analysis of the voting precincts in Oklahoma City.

### Summary

This project is being developed using the R language, an SQL database, and ArcView.  Although much data is supplied, the user is required to obtain certain large datasets on their own.  Once the data is acquired, most of the processing may be done using the ./src/main.R script.  

### Steps to Reproduce the Research

Caveat: Unfortunately this process is not fully automated.  See details in the Summary section above.

1.  Set up SQL Database
    - Create a database named VotersOKC, and run the ./sql/Build-VotersDB.sql script.
    - Create an ODBC Data Source named VotersMSSQL (to use different name, set the sql_dsn variable in main.R).  Instructions for setting up ODBC Data Sources may be found in Appendix A of [./docs/RODBC.pdf](docs/RODBC.pdf)
2.  Download data for registered voters
    - To get registered voter data, it must be [requested](https://www.ok.gov/elections/documents/VIRS%20packet.pdf).  The extracted file diretories were stored in the ./data/large-data/voter-registration and ./data/large-data/voter-history subdirectories. The names of the extracted directories are specified by the dir_voter_registration and dir_voter_history variables in main.R .  Also, make sure to set the projectPath to the local directory name in main.R . 
    - Registered voter info was imported into a database, and then it was merged into a single table.  Additional queries were performed to yield CSV files for reference purposes.  See the sql scripts in the /sql folder.
3.  Download data for  precinct-level voting results
    - Precinct-level voting results may be found [here](https://www.ok.gov/elections/Election_Info/Election_Results/).  These files were stored in the voting-results subdirectory.
4.  Set up ArcMap Maps
    - These maps are important because this project currently relies on ArcMap's geoprocessing functionality.  If time permits, this will be automatic with python scripts that work with the ArcMap code directly.
    - Area calculations are needed for statistical purposes, so a Projected Coordinate System is necessary (NAD_1983_StatePlane_Oklahoma_North_FIPS_3501_Feet).  The CalculateGeometry function on ArcMap was used to produce a field called SquareFt on several critical shapefiles.
5.  An Oklahoma City Voting Precinct Shapefiles and KML files must be created for reporting
    - Voting Precinct GIS Shapefiles were obtained [here](http://csa.ou.edu/redistricting/).  The following counties are included in OKC: Canadian, Cleveland, Oklahoma, and Pottawatomie counties.
    - The boundaries of the 8 Wards in OKC were downloaded as a KMZ file from [here](https://data.okc.gov/portal/desktop/page/datasets?view=download&datasetname=City%20Council%20Wards) and then unzipped into a KML file using 7zip.
6.  Download census data from the federal government
    - 2011-2015 Detailed Tables for Oklahoma were downloaded from [here](https://www.census.gov/geo/maps-data/data/tiger-data.html), extracted, and stored in ./data/large-data/census-data 
    - The statewide census shapefile was intersected with the OKC precinct shapefile using ArcView.  Additionally, area was calcuated
    - The data is in ESRI GDB format, and was opened using ArcMap, and many data tables were exported into the ./output/census-data folder.
    - Square feet area was calculated for the census tracts using ArcMap, and an intersection was done with the OKC Precincts shapefile.  Once again, square feet area was calculated for the intersected shapefile. The challenge will be to convert U.S. census data from a census tract domain to an OKC voter precinct domain.