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
data$Global_active_power = as.numeric(data$Global_active_power)
data$Global_reactive_power = as.numeric(data$Global_reactive_power)
data$Voltage = as.numeric(data$Voltage)
data$Sub_metering_1 = as.numeric(data$Sub_metering_1)
data$Sub_metering_2 = as.numeric(data$Sub_metering_2)
data$Sub_metering_3 = as.numeric(data$Sub_metering_3)
dateTime = strptime(paste(data$Date, data$Time, sep = " "), "%Y-%m-%d %H:%M:%S")

# create the plot
png("plot4.png", width = 480, height = 480)

# set layout
par(mfrow = c(2,2))

# add plot 1
plot(dateTime, data$Global_active_power, type = "l", ylab="Global Active Power", xlab="")

# add plot 2
plot(dateTime, data$Voltage, type = "l", ylab="Voltage", xlab="datetime")

# add plot 3
plot(dateTime, data$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(dateTime, data$Sub_metering_2, col = "red")
lines(dateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, lwd=2.5, bty = "n")

# add plot 4
plot(dateTime, data$Global_reactive_power, type = "l", ylab="Global_reactive_poswer", xlab="datetime")

dev.off()