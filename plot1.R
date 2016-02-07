#
# Get the file if it does not exist
#

datafile <- "household_power_consumption.txt"
if (!file.exists(datafile)) {
    tfile <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tfile)
    datafile <- unzip(tfile)
    unlink(tfile)
}
readfile <- read.table(datafile, header=TRUE, sep=";")  ## Read file with Header 
readfile$Date <- as.Date(readfile$Date, format="%d/%m/%Y")  ## Converts to date YYYY-MM-DD
ds <- readfile[(readfile$Date=="2007-02-01") | (readfile$Date=="2007-02-02"),]  # Creates subset of data
#
# reset all columns as numeric
#
ds <- transform(ds, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
ds$Global_active_power <- as.numeric(as.character(ds$Global_active_power))
ds$Global_reactive_power <- as.numeric(as.character(ds$Global_reactive_power))
ds$Voltage <- as.numeric(as.character(ds$Voltage))
ds$Sub_metering_1 <- as.numeric(as.character(ds$Sub_metering_1))
ds$Sub_metering_2 <- as.numeric(as.character(ds$Sub_metering_2))
ds$Sub_metering_2 <- as.numeric(as.character(ds$Sub_metering_2))
ds$Global_intensity <- as.numeric(as.character(ds$Global_intensity))

plot1 <- function() {
  hist(ds$Global_active_power, main = paste("Global Active Power"), col="red", xlab = "Global Active Power (kilowatts)")
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("Plot1.png -->", getwd())
}

plot1()


