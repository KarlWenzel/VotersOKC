# VotersOKC

### Purpose

To provide basic voter analysis of the voting precincts in Oklahoma City.

### Steps to Reproduce the Research

Caveat: Unfortunately this process is not fully automated, however except for large data sets (which cannot be published to GitHub), all of the intermediate data is provided in this repo.  This means that after the user clones this repository, then only a few additional steps will be necessary to reproduce the research.  

1.  Set up SQL Database DSN
    - Create an ODBC Data Source named VotersMSSQL (to use different name, set the sql_dsn variable in main.R).  Instructions for setting up ODBC Data Sources may be found in Appendix A of [./docs/RODBC.pdf](docs/RODBC.pdf)
2.  Download data for registered voters
    - To get registered voter data, it must be [requested](https://www.ok.gov/elections/documents/VIRS%20packet.pdf).  The extracted file diretories were stored in the ./data/large-data/voter-registration and ./data/large-data/voter-history subdirectories. The names of the extracted directories are specified by the dir_voter_registration and dir_voter_history variables in main.R .  Also, make sure to set the projectPath to the local directory name in main.R . 
    - Registered voter info was imported into a database, and then it was merged into a single table.  Additional queries were performed to yield CSV files for reference purposes.  See the sql scripts in the /sql folder.
3.  Download data for  precinct-level voting results
    - Precinct-level voting results may be found [here](https://www.ok.gov/elections/Election_Info/Election_Results/).  These files were stored in the voting-results subdirectory.
4.  Set up ArcView Maps
    - ./output/arcview-maps/Basic-Map.mxd
    - ./output/arcview-maps/Census-Map.mxd
5.  An Oklahoma City Voting Precinct Shapefile and KML file must be created for reporting
    - Voting Precinct GIS Shapefiles were obtained [here](http://csa.ou.edu/redistricting/).  The following counties are included in OKC: Canadian, Cleveland, Oklahoma, and Pottawatomie counties.
    - The boundaries of the 8 Wards in OKC were downloaded as a KMZ file from [here](https://data.okc.gov/portal/desktop/page/datasets?view=download&datasetname=City%20Council%20Wards) and then unzipped into a KML file using 7zip.
    - [create-precinct-shapefile.R](src/create-precinct-shapefile.R) was used to build SHP and KML files delineating the 224 precincts of OKC.
6.  Download census data from the federal government
    - 2011-2015 Detailed Tables for Oklahoma were downloaded from [here](https://www.census.gov/geo/maps-data/data/tiger-data.html), extracted, and stored in ./data/large-data/census-data 
    - The statewide census shapefile was interected with the OKC precinct shapefile using ArcView.  Additionally, area was calcuated
    - The data is in ESRI GDB format, and was opened using ArcView, and many data tables were exported into the ./output/census-data folder.