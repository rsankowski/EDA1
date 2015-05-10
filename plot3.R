##download data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir.create("./EDA1/")
setwd("./EDA1/")
download.file(url,destfile="./data1.zip", method = "curl")

##unzip and read data
data1 <- unzip ("data1.zip", exdir = "./")
data <- read.table("household_power_consumption.txt", sep=";", header = T, stringsAsFactors = FALSE)

##convert dates into Date class
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## subset dataset for the 2 required days
subdata1 <- data[grep("2007-02-01",data$Date),] ##day1
subdata2 <- data[grep("2007-02-02",data$Date),] ##day 2 
subdata <- rbind(subdata1, subdata2) ## merge both days
rm(data)  ##remove the original large file

##merge Date and Time Columns and reformat as date
library(lubridate)
subdata$Day <- paste(subdata$Date, subdata$Time)
subdata$Time <- ymd_hms(subdata$Day)

##convert Sub_metering data to numeric
subdata$Sub_metering_1 <- as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2 <- as.numeric(subdata$Sub_metering_2)
subdata$Sub_metering_3 <- as.numeric(subdata$Sub_metering_3)

## drawing plot3
par(cex = 0.75)
plot(subdata$Time, subdata$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "") ##plot the males first
lines(subdata$Time, subdata$Sub_metering_2, type = "l", col = "red") ##plot the males first
lines(subdata$Time, subdata$Sub_metering_3, type = "l", col = "blue") ##plot the males first
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, cex = 0.8, col = c("black", "red", "blue"))
dev.copy(png, file = "plot3.png")
dev.off()

