library(rgeos)
library(rgdal)
library("RColorBrewer")

projectPath = "E:/git/VotersOKC"
shp_okc_precincts = readOGR(paste(projectPath, "/shapefiles/OKC_Precincts/OKC_Precincts.shp", sep=""), "OKC_Precincts")

# Find the center of each region and label lat and lon of centers
centroids <- gCentroid(shp_okc_precincts, byid=TRUE)
centroidLongs <- coordinates(centroids)[,1]
centroidLats <- coordinates(centroids)[,2]


cols = colorRampPalette(brewer.pal(11,"Spectral"))(length(shp_okc_precincts))
bins = .bincode(
  shp_okc_precincts$RgstrdV, 
  c(0, seq(600, max(shp_okc_precincts$RgstrdV), length.out=10))
)

plot(shp_okc_precincts, col=cols[bins], main="OKC Precincts")
text(centroidLongs, centroidLats, labels=df$precinct, col="black", cex=.7)


#df = data.frame(seq = 1:nrow(shp_okc_precincts), precinct = shp_okc_precincts$Precinct)
#df = df[order(df$precinct),]
#df$colSeq = 1:nrow(shp_okc_precincts)
#df = df[order(df$seq),]
#cols = colorRampPalette(brewer.pal(11,"Spectral"))(length(shp_okc_precincts))
#cols = cols[df$colSeq]