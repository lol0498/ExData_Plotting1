# Read data
elec_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                        na.strings = "?")
head(elec_data)

# Set date and time correctly
elec_data$Date <- as.Date(elec_data$Date, "%d/%m/%Y")
plot_data <- subset(elec_data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

head(plot_data)

dateTime <- paste(plot_data$Date, plot_data$Time)
dateTime <- setNames(dateTime, "DateTime")

plot_data <- plot_data[ ,!(names(plot_data) %in% c("Date","Time"))]
plot_data <- cbind(dateTime, plot_data)
plot_data$dateTime <- as.POSIXct(dateTime)

# Plotting
# Plot 1
hist(plot_data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()