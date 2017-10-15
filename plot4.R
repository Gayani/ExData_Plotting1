fileName <- "dataset.zip"
if (!file.exists(fileName)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,fileName,mode='wb')
}
dataFile <- "household_power_consumption.txt"
if (!file.exists(dataFile)) { 
  unzip(fileName) 
}
data <- read.table(dataFile, header=TRUE, sep=";",na.strings = "?")
SubData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
globalActivePower <- as.numeric(SubData$Global_active_power)
datetime <- strptime(paste(SubData$Date, SubData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(SubData$Global_active_power)
globalReactivePower <- as.numeric(SubData$Global_reactive_power)
voltage <- as.numeric(SubData$Voltage)
subMtr1 <- as.numeric(SubData$Sub_metering_1)
subMtr2 <- as.numeric(SubData$Sub_metering_2)
subMtr3 <- as.numeric(SubData$Sub_metering_3)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power")

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMtr1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMtr2, type="l", col="red")
lines(datetime, subMtr3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"),bty = "n")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
