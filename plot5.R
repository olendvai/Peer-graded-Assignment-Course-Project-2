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

#based on the following webpage: emissions are grouped into 8 major source sector, 
#and one of the major source sector is Mobile. 
#Under that category, there are several vehicle classes. 
#Based on Wikipedia description of motor vehicles, non-road equipment was included, 
while aircraft, marine vessels and locomotives were excluded. 

#a subset is made for these and the SCC identifiers are assigned to variables

motorVehicles <- subset(SCC, EI.Sector =="Mobile - On-Road Gasoline Light Duty Vehicles" |
EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" |
EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles" |
EI.Sector == "Mobile - Non-Road Equipment - Gasoline" |
EI.Sector == "Mobile - Non-Road Equipment - Other" |
EI.Sector == "Mobile - Non-Road Equipment - Diesel")


NEImotorVehicles <- subset(NEI, SCC %in% motorVehicles$SCC)

NEImotorVehiclesBaltimore <- subset(NEImotorVehicles, fips == "24510")

tempyears <- unique(NEImotorVehiclesBaltimore$year)

g <- ggplot(NEImotorVehiclesBaltimore, aes(year, Emissions))
g1 <- g + geom_point(col = "red", size = 4, alpha =0.2)
g2 <- g1 + geom_smooth(method ="lm", se = T, size =1, col = "black")
g3 <- g2 +labs( x= "Years", y ="Emission (tons)",title = "Motor vehicle related PM2.5 Emission in Baltimore City")
g3 + scale_x_continuous(breaks = tempyears)

dev.copy(png, file = "plot5.png")
dev.off()