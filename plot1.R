# Read data file
householdData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Create Date-Time variable by concatenating date and time, and then converting it to a date-time field
householdData$DateTime <- paste(householdData$Date, householdData$Time)
householdData$DateTime <- strptime(householdData$DateTime, format="%d/%m/%Y %H:%M:%S")

# Filter (subset) on DateTime between 01-02-2077 and 02-02-2007
requiredHouseholdData <- subset(householdData, DateTime >= strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S") & DateTime < strptime("03/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))

# Convert Global Active Power to a number
# No need to take out NAs (?) as there are none in the Global Active Power column for these dates
requiredHouseholdData$Global_active_power <- as.numeric(as.character(requiredHouseholdData$Global_active_power))

# Create png-device
png(filename="plot1.png", width=480, height=480, units="px")

# Create Histogram
hist(requiredHouseholdData$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Close png-device
dev.off()