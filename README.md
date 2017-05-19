# VotersOKC

### Purpose

To provide basic voter analysis of the voting precincts in Oklahoma City.

### Steps to Reproduce the Research

1.  An Oklahoma City Voting Precinct Shapefile must be created
    - Voting Desistric GIS Shapefiles were obtained [here](http://csa.ou.edu/redistricting/).  The following counties are included in OKC: Canadian, Cleveland, Oklahoma, and Pottawatomie counties.
    - An Incorporated Area GIS Shapefile was obtaind from ?
    - Using ArcMap (or some other geoprocessing tool), the 4 county files were merged, the incorporated area was filtered down to only Oklahma City, and then the results were intersected, yielding a filed named [OKC_Joined.shp](./shapefiles/OKC_Joined.shp).
2.  Download data for registered voters
    - To get registered voter data, it must be [requested](https://www.ok.gov/elections/documents/VIRS%20packet.pdf).  These files were stored in the registered-voter subdirectory
    - Registered voter info was loaded into a database and merged into a single table.
3.  Download data for  precinct-level voting results
    - Precinct-level voting results may be found [here](https://www.ok.gov/elections/Election_Info/Election_Results/).  These files were stored in the voting-results subdirectory.