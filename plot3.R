#if(!file.exists("./Source_Classification_Code.rds")|!file.exists("./summarySCC_PM25.rds")){
#dir.create("./pm25")
#fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(fileUrl, destfile = "./pm25/pm25.zip")
#unzip("./pm25/pm25.zip")
#unlink("./pm25", recursive = TRUE)
#}

#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#since NEI and SCC variables are avaible in the working environment, there is no need to download the zip file and read them to the variables.

#NEIBaltimore <- subset(NEI, fips=="24510")

#NEIBaltimore variable is also available in the working environment

tempyears <- unique(NEIBaltimore$year)

g <- ggplot(NEIBaltimore, aes(year, Emissions))
g1 <- g + geom_point(aes(color = type), size = 4, alpha = .5)
g2 <- g1 + coord_cartesian(ylim= c(0,400))
g3 <- g2 + geom_smooth(method ="lm", se = FALSE, size =1, aes(color = type))
g4 <- g3 +labs( x= "Years", y ="Emission (tons)",title = "PM2.5 Emission of Baltimore City(Maryland)")
g4 + scale_x_continuous(breaks = tempyears)

dev.copy(png, file = "plot3.png")
dev.off()