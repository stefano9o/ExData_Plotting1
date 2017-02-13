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

#Plot data
png(filename = "plot4.png", 
    width = 480, 
    height = 480, 
    units = "px")

par(mfrow=c(2,2))
#plot1
with(df,plot(Date_time,Global_active_power, ylab = "Global Active Power (kilowatts)",type="l",xlab =""))
#plot2
with(df,plot(Date_time,Voltage, ylab = "Voltage",type="l",col = "black",xlab ="datetime"))
#plot3
with(df,plot(Date_time,Sub_metering_1, ylab = "Energy sub metering",type="l",col = "black",xlab =""))
with(df,lines(Date_time,Sub_metering_2,col="red"))
with(df,lines(Date_time,Sub_metering_3,col="blue"))
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       bty="n",
       col=c("black","red","blue")) # gives the legend lines the correct color and width
with(df,plot(Date_time,Global_reactive_power, ylab = "Voltage",type="l",col = "black",xlab ="datetime"))

dev.off() 