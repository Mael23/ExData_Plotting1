## plot3.R

filename <- "household_power_consumption.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename)
}  
if (!file.exists("household_power_consumption")) { 
        unzip(filename) 
}

## Subset appropriate data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   stringsAsFactors = FALSE)
dataSub <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]
dateTime <- strptime(paste(dataSub$Date, dataSub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(dataSub$Global_active_power)
subMet1 <- as.numeric(dataSub$Sub_metering_1)
subMet2 <- as.numeric(dataSub$Sub_metering_2)
subMet3 <- as.numeric(dataSub$Sub_metering_3)

## Construct plot
png("plot3.png", width=480, height=480)
plot(dateTime, subMet1, type="l", ylab="Energy sub metering", xlab="")
lines(dateTime, subMet2, type="l", col="red")
lines(dateTime, subMet3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()