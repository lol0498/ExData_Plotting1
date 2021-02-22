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

# Plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1))
with(plot_data, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lwd=1, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global_reactive_power", xlab="datetime")
})
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()