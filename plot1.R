if(!file.exists("./Source_Classification_Code.rds")|!file.exists("./summarySCC_PM25.rds")){
dir.create("./pm25")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./pm25/pm25.zip")
unzip("./pm25/pm25.zip")
unlink("./pm25", recursive = TRUE)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEISumYear <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))

NEISumYearPerMillion <- NEISumYear/1000000

barplot(NEISumYearPerMillion, xlab = "Years", ylab = "Emission (million tons)", ylim = c(0,8), main = "Total PM2.5 emission in the United States" )
text(NEISumYearPerMillion+0.4, labels = as.character(round(NEISumYearPerMillion, digits = 2)))
lines(NEISumYearPerMillion, col = "magenta", lwd = 2)

dev.copy(png, file = "plot1.png")
dev.off()