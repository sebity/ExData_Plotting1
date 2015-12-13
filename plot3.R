# Load data.table library
library(data.table)

## Data Filter
date_start = as.Date("2007-02-01")
date_end   = as.Date("2007-02-02")

# Data file to be loaded
data_file <- "household_power_consumption.txt"

# Load the data into hpd_data
hpd_data <- fread(data_file, header=TRUE, sep=";", na.strings="?")

# Format Date
hpd_data$Date <- as.Date(hpd_data$Date, format="%d/%m/%Y")

# Extract subset of data to be plotted
hpd_subset <- subset(hpd_data, hpd_data$Date >= date_start & hpd_data$Date <= date_end)

# Convert Date format
datetime <- paste(hpd_subset$Date, hpd_subset$Time)
hpd_subset$DateTime <- as.POSIXct(datetime)

# Open PNG device
png(filename = "plot3.png", width = 480, height = 480)

# Set the margins
par(mar = c(4,4,2,2))

# Plot an empty graph
plot(hpd_subset$DateTime, hpd_subset$Sub_metering_1, 
     ylab = "Energy sub metering", 
     xlab="", 
     type = "n")

# Plot the points on the graph
points(hpd_subset$DateTime, hpd_subset$Sub_metering_1, type="l")
points(hpd_subset$DateTime, hpd_subset$Sub_metering_2, type="l", col="red")
points(hpd_subset$DateTime, hpd_subset$Sub_metering_3, type="l", col="blue")

# Create the Legend
legend("topright", 
       lty=c(1,1,1), 
       col=c("black","red","blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the PNG file device
dev.off()