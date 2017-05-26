# VotersOKC

### Purpose

To provide basic voter analysis of the voting precincts in Oklahoma City.

### Steps to Reproduce the Research

1.  Download data for registered voters
    - To get registered voter data, it must be [requested](https://www.ok.gov/elections/documents/VIRS%20packet.pdf).  These files were stored in the registered-voter subdirectory
    - Registered voter info was imported into a database, and then it was merged into a single table.  Additional queries were performed to yield CSV files for reference purposes.  See the sql scripts in the /sql folder.
2.  Download data for  precinct-level voting results
    - Precinct-level voting results may be found [here](https://www.ok.gov/elections/Election_Info/Election_Results/).  These files were stored in the voting-results subdirectory.
3.  An Oklahoma City Voting Precinct Shapefile and KML file must be created for reporting
    - Voting Precinct GIS Shapefiles were obtained [here](http://csa.ou.edu/redistricting/).  The following counties are included in OKC: Canadian, Cleveland, Oklahoma, and Pottawatomie counties.
    - The boundaries of the 8 Wards in OKC were downloaded as a KMZ file from [here](https://data.okc.gov/portal/desktop/page/datasets?view=download&datasetname=City%20Council%20Wards) and then unzipped into a KML file using 7zip.
    - [create-precinct-shapefile.R](src/create-precinct-shapefile.R) was used to build SHP and KML files delineating the 224 precincts of OKC.