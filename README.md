# VotersOKC

### Purpose

To provide basic voter analysis of the voting precincts in Oklahoma City.

### Steps to Reproduce the Research

1.  An Oklahoma City Voting Precinct Shapefile must be created
    - Voting Desistric GIS Shapefiles were obtained [here](http://csa.ou.edu/redistricting/).  The following counties are included in OKC: Canadian, Cleveland, Oklahoma, and Pottawatomie counties.
    - An Incorporated Area GIS Shapefile was obtaind from ?
    - Using ArcMap (or some other geoprocessing tool), the 4 county files were merged, the incorporated area was filtered down to only Oklahma City, and then the results were intersected, yielding a filed named [OKC_Joined.shp](./shapefiles/OKC_Joined.shp).
    - Run [build-precinct-index.R](./src/build-precinct-index.R).
2.  Download data for registered voters and precinct-level voting results
    - To get registered voter data, it must be [requested](./registered-voters/VIRS-packet.pdf).  These files were stored in the registered-voter subdirectory
    - Precinct-level voting results may be found [here](https://www.ok.gov/elections/Election_Info/Election_Results/).  These files were stored in the voting-results subdirectory.