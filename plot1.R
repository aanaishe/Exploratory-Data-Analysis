library(dplyr)

## Download data
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if (!file.exists('Coursera/exdata-data-household_power_consumption.zip')) {
    download.file(url, 'Coursera/exdata-household_power_consumption.zip')
    unz('Coursera/exdata-data-household_power_consumption.zip', exdir='./Coursera')
}

## Read data into R
HPCData <- read.csv2("Coursera/household_power_consumption.txt", na.strings="?", stringsAsFactors = FALSE)
head(HPCData)

## Select the information with the desired dates "2007-02-01" and "2007-02-02"
HPCData[,"Date"] <- as.Date(HPCData[,"Date"], "%d/%m/%Y")
DesiredDates = as.Date(c("2007-02-01","2007-02-02"))
HPCData2 = subset(HPCData, HPCData[,"Date"] %in% DesiredDates)

## Change the class of "Global_active_power" from character to numeric
HPCData2[,"Global_active_power"] <- as.numeric(HPCData2[,"Global_active_power"])

## Generate plot1 and save as a png file
png("plot1.png",width=480,height=480,units="px")
hist((HPCData2$Global_active_power), col="red", main="Global Active Power", 
        xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
