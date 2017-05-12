require(rgdal)

projectPath = "E:/git/VotersOKC"
data = readOGR(paste(projectPath, "/shapefiles", sep=""), "OKC_Joined")
x = unique(as.numeric(as.character(data$Precinct)))
y = x + 550000
df = data.frame(precinct = x, precinctCode = y)
df = df[ order(df$precinctCode), ]
write.csv(df, paste(projectPath, "/shapefiles/OKC-Distinct-Precincts.csv", sep=""))