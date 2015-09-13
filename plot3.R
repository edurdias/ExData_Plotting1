# download file
remoteFileName = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp = tempfile()
download.file(remoteFileName, temp)

# load the data
dataFile = unz(temp, "household_power_consumption.txt")
data = read.csv(dataFile, header = TRUE, sep=";", stringsAsFactors = FALSE)
unlink(temp)

# subset the data
data$Date = as.Date(data$Date, format = "%d/%m/%Y")
data = subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# convert necessary fields
data$Sub_metering_1 = as.numeric(data$Sub_metering_1)
data$Sub_metering_2 = as.numeric(data$Sub_metering_2)
data$Sub_metering_3 = as.numeric(data$Sub_metering_3)
dateTime = strptime(paste(data$Date, data$Time, sep = " "), "%Y-%m-%d %H:%M:%S")

# create the plot
png("plot3.png", width = 480, height = 480)
plot(dateTime, data$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")

# add other data series
lines(dateTime, data$Sub_metering_2, col = "red")
lines(dateTime, data$Sub_metering_3, col = "blue")

# create the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, lwd=2.5)
dev.off()