## Download zip file, unzip it, and remove zipped file
## Note: at the end of the scipt, the data file will be
## deleted as well in order to get a clean directory
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, temp)
file <- unzip(temp)
unlink(temp)

## Reading the data file
data <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors=FALSE, na.string = "?")

## Converting date as strings to objects of class POSIXlt
## and use these objects to subset the data frame
data$DateTime <- strptime(paste(data$Date, data$Time),"%d/%m/%Y %H:%M:%S")
data <- subset(data, DateTime >= strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S") & DateTime <= strptime("2007-02-0223:59:59", "%Y-%m-%d %H:%M:%S"))

## Generate plot with 480 x 480px (default size) according
## to the project task even though the figures on the page and
## github have a different size. Additionally, the background
## color was changed to transparent instead of white (default)
## since the figures on the page and github have a transparent
## background color.
png(filename="plot3.png", bg="transparent")
plot(data$DateTime, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering", main="")
lines(data$DateTime, data$Sub_metering_1, type="l", col="black")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col=c("black", "red", "blue"))
dev.off()

## delete data file
unlink(file)
