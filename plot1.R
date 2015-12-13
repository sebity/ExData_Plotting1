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

# Open PNG device
png(filename = "plot1.png", width = 480, height = 480)

# Plot the histogram
hist(hpd_subset$Global_active_power, main="Global Active Power", col="Red", xlab="Global Active Power (kilowatts)", breaks=12)

# Close the PNG file device
dev.off()