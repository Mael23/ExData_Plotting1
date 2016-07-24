## plot2.R

filename <- "household_power_consumption.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename)
}  
if (!file.exists("household_power_consumption")) { 
        unzip(filename) 
}

## Subset appropriate data (dates and Global_active_power)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   stringsAsFactors = FALSE)
dataSub <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]
dateTime <- strptime(paste(dataSub$Date, dataSub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(dataSub$Global_active_power)

## Construct plot
png("plot2.png", width=480, height=480)
plot(dateTime, globalActivePower, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()
