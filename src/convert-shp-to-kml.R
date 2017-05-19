library(rgeos)
library(rgdal)

projectPath = "D:/git/VotersOKC"
data = readOGR(paste(projectPath, "/shapefiles/OKC_precinct", sep=""), "OKC_precinct")
writeOGR(data, paste(projectPath, "/shapefiles/OKC_precinct/OKC_precinct.kml", sep=""), "OKC_precinct", driver="KML")