require(rgdal)

projectPath = "E:/git/VotersOKC"
data = readOGR(paste(projectPath, "/shapefiles", sep=""), "OKC_Joined")
plot(data)