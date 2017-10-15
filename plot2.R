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
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()