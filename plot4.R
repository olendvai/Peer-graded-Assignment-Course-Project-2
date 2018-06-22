if(!file.exists("./Source_Classification_Code.rds")|!file.exists("./summarySCC_PM25.rds")){
dir.create("./pm25")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./pm25/pm25.zip")
unzip("./pm25/pm25.zip")
unlink("./pm25", recursive = TRUE)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#since NEI and SCC variables are avaible in the working environment, there is no need to download the zip file and read them to the variables.

#based on the following webpage: https://www.epa.gov/air-emissions-inventories/air-emissions-sources, emissions are grouped into 8 major source sector, 
#and one of the major source sector is Fuel Combustion. Under that category, three coal related emissions are listed: 
#Comm/Institutional - Coal
#Electric Generation - Coal
#Industrial Boilers, ICEs - Coal

#a subset is made for these and the SCC identifiers are assigned to variables

electric <- subset(SCC, EI.Sector =="Fuel Comb - Electric Generation - Coal")
boilers <- subset(SCC, EI.Sector =="Fuel Comb - Industrial Boilers, ICEs - Coal")
comminst <- subset(SCC, EI.Sector =="Fuel Comb - Comm/Institutional - Coal")

NEIelectric <- subset(NEI, SCC %in% electric$SCC)
NEIelectric <- mutate(NEIelectric, source = "Electric Generation")

NEIboilers <- subset(NEI, SCC %in% boilers$SCC)
NEIboilers <- mutate(NEIboilers, source = "Industrial Boilers")

NEIcomminst <- subset(NEI, SCC %in% comminst$SCC)
NEIcomminst <- mutate(NEIcomminst, source = "Comm/Institutional")

NEIcoal <- rbind(NEIelectric, NEIboilers, NEIcomminst)

tempyears <- unique(NEIcoal$year)

g <- ggplot(NEIcoal, aes(year, Emissions))
g1 <- g + geom_point(col = "red", size = 4, alpha =0.2)
g2 <- g1 + geom_smooth(method ="lm", se = T, size =1, col = "black")
g3 <- g2 +labs( x= "Years", y ="Emission (tons)",title = "Coal Combustion related PM2.5 Emission in the United States")
g3 + scale_x_continuous(breaks = tempyears)

dev.copy(png, file = "plot4.png")
dev.off()