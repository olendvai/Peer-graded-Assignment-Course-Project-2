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

NEIBaltimore <- subset(NEI, fips=="24510")


NEISumYear <- with(NEIBaltimore, tapply(Emissions, year, sum, na.rm = TRUE))

barplot(NEISumYear, xlab = "Years", ylab = "Emission (tons)", ylim = c(0,3500), main = "Total PM2.5 emission in Baltimore City(Maryland)" )
text(NEISumYear+150, labels = as.character(round(NEISumYear, digits = 2)))
lines(NEISumYear, col = "magenta", lwd = 2)

dev.copy(png, file = "plot2.png")
dev.off()