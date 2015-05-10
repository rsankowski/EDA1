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

##merge Date and Time Columns and reformat as date
  library(lubridate)
  subdata$Day <- paste(subdata$Date, subdata$Time)
  subdata$Time <- ymd_hms(subdata$Day)

## drawing plot2
  par(cex = 0.75)
  plot(subdata$Time, subdata$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")
  dev.copy(png, file = "plot2.png")
  dev.off()

