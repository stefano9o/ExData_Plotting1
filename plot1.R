library(datasets)

##download the fzip ile
zipFilename <- "household_power_consumption.zip"
filename <- "household_power_consumption.txt"

##download the zip file
if(!file.exists(zipFilename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,zipFilename)
}

##decompress the zip file
if (!file.exists(filename)){ 
  unzip(zipFilename) 
}

##read the table
df <- read.table(filename,sep = ";", header = TRUE, stringsAsFactors = FALSE,na.strings = "?")

##filter only the observations inside the range 1/2/2007 2/2/2007
df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007",]

##create the datetime columns
df$Date_time <- strptime(paste(df$Date, df$Time),"%d/%m/%Y %H:%M:%S")

png(filename = "plot1.png", 
    width = 480, 
    height = 480, 
    units = "px")

with(df,hist(Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency",col = "red"))

dev.off() 