## plot4.R

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
globalReactivePower <- as.numeric(dataSub$Global_reactive_power)
volt <- as.numeric(dataSub$Voltage)
subMet1 <- as.numeric(dataSub$Sub_metering_1)
subMet2 <- as.numeric(dataSub$Sub_metering_2)
subMet3 <- as.numeric(dataSub$Sub_metering_3)

## Construct plots
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

## First plot (top left quadrant)
plot(dateTime, globalActivePower, type="l", xlab="", 
     ylab="Global Active Power", cex=0.2)

## Second plot (top right quadrant)
plot(dateTime, volt, type="l", xlab="datetime", ylab="Voltage")

## Third plot (bottom left quadrant)
plot(dateTime, subMet1, type="l", ylab="Energy sub metering", xlab="")
lines(dateTime, subMet2, type="l", col="red")
lines(dateTime, subMet3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

## Fourth plot (bottom right quadrant)
plot(dateTime, globalReactivePower, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()