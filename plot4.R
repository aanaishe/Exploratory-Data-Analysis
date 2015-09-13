## Download the data
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if (!file.exists('Coursera/exdata-data-household_power_consumption.zip')) {
  download.file(url, 'Coursera/exdata-household_power_consumption.zip')
  unz('Coursera/exdata-data-household_power_consumption.zip', exdir='./Coursera')
}

## Read the data into R
HPCData <- read.csv2("Coursera/household_power_consumption.txt", na.strings="?", stringsAsFactors = FALSE)
head(HPCData)

## Select the information that corresponds to the desired dates "2007-02-01" and "2007-02-02"
HPCData[,"Date"] <- as.Date(HPCData[,"Date"], "%d/%m/%Y")
DesiredDates = as.Date(c("2007-02-01","2007-02-02"))
HPCData2 = subset(HPCData, HPCData[,"Date"] %in% DesiredDates)

## Change the class of "Global_active_power", "Voltage", and "Global_reactive_power" from character to numeric
HPCData2[,"Global_active_power"] <- as.numeric(HPCData2[,"Global_active_power"])
HPCData2[,"Voltage"] <- as.numeric(HPCData2[,"Voltage"])
HPCData2[,"Global_reactive_power"] <- as.numeric(HPCData2[,"Global_reactive_power"])

## Change the class of date and time to "POSIXct
DT <- paste(as.Date(HPCData2$Date), HPCData2$Time)
HPCData2$DT <- as.POSIXct(DT)

## Generate plot4 and save as a .png file
png("plot4.png",width=480,height=480,units="px")

par(mfrow = c(2, 2))

plot(HPCData2$DT, HPCData2$Global_active_power, type="l", ylab="Global Active Power", 
     xlab=" ")

plot(HPCData2$DT, HPCData2$Voltage, type="l", ylab="Voltage", 
     xlab="datetime")

plot(HPCData2$Sub_metering_1~HPCData2$DT,ann=FALSE,type="l")
lines(HPCData2$Sub_metering_1~HPCData2$DT, col="black")
lines(HPCData2$Sub_metering_2~HPCData2$DT, col="red")
lines(HPCData2$Sub_metering_3~HPCData2$DT, col="blue")
title(ylab="Energy sub metering")
legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c('black','red','blue'), lty=1)

plot(HPCData2$DT, HPCData2$Global_reactive_power, type="l", ylab="Global_reactive_power", 
     xlab="datetime")

dev.off()
