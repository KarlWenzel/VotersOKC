require(rgdal)
library("RColorBrewer")

projectPath = "E:/git/VotersOKC"
data = readOGR(paste(projectPath, "/shapefiles", sep=""), "OKC_Joined")

df = data.frame(seq = 1:nrow(data), precinct = as.numeric(as.character(data$Precinct)))
df = df[order(df$precinct),]
df$colSeq = 1:nrow(data)
df = df[order(df$seq),]

cols = colorRampPalette(brewer.pal(length(data),"Spectral"))(length(data))
cols = cols[df$colSeq]
plot(data, col=cols)