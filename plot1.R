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
png(filename="plot1.png", bg="transparent")
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()

## delete data file
unlink(file)
