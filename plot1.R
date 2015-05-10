##download data
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  dir.create("./EDA1/")
  setwd("./EDA1/")
  download.file(url,destfile="./data1.zip", method = "curl")

##unzip and read data
  data1 <- unzip ("data1.zip", exdir = "./")
  data <- read.table(data1, sep=";", header = T, stringsAsFactors = FALSE)

##convert dates into Date class
  data$Date <- as.Date(data$Date, "%d/%m/%Y")

## subset dataset for the 2 required days
  subdata1 <- data[grep("2007-02-01",data$Date),] ##day1
  subdata2 <- data[grep("2007-02-02",data$Date),] ##day 2 
  subdata <- rbind(subdata1, subdata2) ## merge both days
  rm(data)  ##remove the original large file

##convert the Global Active power into numeric
  subdata$Global_active_power <- as.numeric(subdata$Global_active_power)

## drawing plot1
  par(cex = 0.75)
  hist(subdata$Global_active_power, col="red", breaks = 16, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", axes = FALSE)
  axis(1, seq(0,6, by=2))
  axis(2, seq(0,1200, by=200), cex.lab=0.5)
  dev.copy(png, file = "plot1.png")
  dev.off()
