library(rgeos)
library(rgdal)
library("RColorBrewer")

projectPath = "D:/git/VotersOKC"
data = readOGR(paste(projectPath, "/shapefiles/OKC_precinct", sep=""), "OKC_precinct")
data$Precinct = as.numeric(as.character(data$Precinct))

df = data.frame(seq = 1:nrow(data), precinct = data$Precinct)
df = df[order(df$precinct),]
df$colSeq = 1:nrow(data)
df = df[order(df$seq),]

cols = colorRampPalette(brewer.pal(11,"Spectral"))(length(data))
cols = cols[df$colSeq]

# Find the center of each region and label lat and lon of centers
centroids <- gCentroid(data, byid=TRUE)
centroidLongs <- coordinates(centroids)[,1]
centroidLats <- coordinates(centroids)[,2]

plot(data, col=cols, main="OKC Precincts")
text(centroidLongs, centroidLats, labels=df$precinct, col="black", cex=.7)


