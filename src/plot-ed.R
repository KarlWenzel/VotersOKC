library(rgeos)
library(rgdal)
library(plyr)

projectPath = "E:/git/VotersOKC"
data = readOGR(paste(projectPath, "/shapefiles/OKC_Precincts", sep=""), "OKC_Precincts")
ed = read.csv(paste(projectPath, "/voting-results/Ed20140304.csv", sep=""))

x = data$Precinct[ !(data$Precinct %in% ed$Precinct) ]
ed = rbind(ed, data.frame(Precinct=x, EdVotes=rep(0,length(x)), AllVotes=rep(0,length(x)) ))

ed$VotePercent =  ed$EdVotes * 100 / ed$AllVotes
ed$VotePercent[is.nan(ed$VotePercent)] = 0

breaks = 5*(0:17)
ed$VotePercentInterval = breaks[findInterval(ed$VotePercent, breaks)]

data = merge(data, ed, by="Precinct", all.x=TRUE)
writeOGR(data, paste(projectPath, "/shapefiles/Vote_Results/Ed20140304.kml", sep=""), "Ed20140304.kml", driver="KML")





