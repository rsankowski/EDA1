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

##convert Voltage and Global reactive power to numeric
subdata$Voltage <- as.numeric(subdata$Voltage)
subdata$Global_reactive_power <- as.numeric(subdata$Global_reactive_power)
str(subdata)
## drawing plot4
par(cex.axis = 0.6, cex.lab = 0.6, mfcol = c(2, 2), mar = c(4, 3, 3, 2), mgp = c(2,1,0), tck = -0.25, tcl= -0.25)

##add topleft plot
plot(subdata$Time, subdata$Global_active_power, type="l", xlab="", ylab = "Global Active Power")

##add bottomleft plot
plot(subdata$Time, subdata$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "") 
lines(subdata$Time, subdata$Sub_metering_2, type = "l", col = "red") 
lines(subdata$Time, subdata$Sub_metering_3, type = "l", col = "blue") 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, cex = 0.5, col = c("black", "red", "blue"), bty = "n")

##add topright plot
plot(subdata$Time, subdata$Voltage, type = "l", col = "black", ylab = "Voltage", xlab = "datetime")

##add bottomright plot
plot(subdata$Time, subdata$Global_reactive_power, type = "l", col = "black", ylab = "Global_reactive_power", xlab = "datetime")

##save plot
dev.copy(png, file = "plot4.png")
dev.off()
