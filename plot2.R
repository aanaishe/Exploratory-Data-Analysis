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

## Change the class of Global_active_power from character to numeric
HPCData2[,"Global_active_power"] <- as.numeric(HPCData2[,"Global_active_power"])

## Change the date and time class to POSIXct
DT <- paste(as.Date(HPCData2$Date), HPCData2$Time)
HPCData2$DT <- as.POSIXct(DT)

## Generate plot2 and save as .png file
png("plot2.png",width=480,height=480,units="px")
plot(HPCData2$DT, HPCData2$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", 
     xlab=" ")
dev.off()
