# Read data file
householdData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Create Date-Time variable by concatenating date and time, and then converting it to a date-time field
householdData$DateTime <- paste(householdData$Date, householdData$Time)
householdData$DateTime <- strptime(householdData$DateTime, format="%d/%m/%Y %H:%M:%S")

# Filter (subset) on DateTime between 01-02-2077 and 02-02-2007
requiredHouseholdData <- subset(householdData, DateTime >= strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S") & DateTime < strptime("03/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))

# No need to take out NAs (?) as there are none in the Global Active Power column for these dates

# Create png-device
png(filename="plot3.png", width=480, height=480, units="px")

# Create Plot, but without the data
# Read data file
householdData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Create Date-Time variable by concatenating date and time, and then converting it to a date-time field
householdData$DateTime <- paste(householdData$Date, householdData$Time)
householdData$DateTime <- strptime(householdData$DateTime, format="%d/%m/%Y %H:%M:%S")

# Filter (subset) on DateTime between 01-02-2077 and 02-02-2007
requiredHouseholdData <- subset(householdData, DateTime >= strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S") & DateTime < strptime("03/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))

# Convert Sub_meterings to a number
# No need to take out NAs (?) as there are none in the Global Active Power column for these dates
requiredHouseholdData$Sub_metering_1 <- as.numeric(as.character(requiredHouseholdData$Sub_metering_1))
requiredHouseholdData$Sub_metering_2 <- as.numeric(as.character(requiredHouseholdData$Sub_metering_2))
requiredHouseholdData$Sub_metering_3 <- as.numeric(as.character(requiredHouseholdData$Sub_metering_3))

# Create png-device
png(filename="plot3.png", width=480, height=480, units="px")

# Create Plot, but without the data, and without Y-axis
# we create it separately to be able to control the numner of ticks
plot(requiredHouseholdData$DateTime, requiredHouseholdData$Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering", yaxt="n")
axis(side=2, col="black", at=c(0, 10, 20, 30), labels=c(0,10,20,30)) 

# Add the data through the lines() function
lines(requiredHouseholdData$DateTime, requiredHouseholdData$Sub_metering_1, col="black")
lines(requiredHouseholdData$DateTime, requiredHouseholdData$Sub_metering_2, col="red")
lines(requiredHouseholdData$DateTime, requiredHouseholdData$Sub_metering_3, col="blue")

# Add the legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))

# Close png-device
dev.off()