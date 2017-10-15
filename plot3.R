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
datetime <- strptime(paste(SubData$Date, SubData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
subMtr1 <- as.numeric(SubData$Sub_metering_1)
subMtr2 <- as.numeric(SubData$Sub_metering_2)
subMtr3 <- as.numeric(SubData$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(datetime, subMtr1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMtr2, type="l", col="red")
lines(datetime, subMtr3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()