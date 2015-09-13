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

# create the plot
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col="red",main="Global Active Power", ylab="Frequency", xlab="Global Active Power (kilowatts)")
dev.off()