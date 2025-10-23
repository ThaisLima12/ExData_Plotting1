# check the directory your working
getwd() 

# check if the data file is in the correct directory. 
# If not, transfer or give the complete pathway
file.exists("household_power_consumption.txt") 

# Read only the 2 days you want to analyse from the dataset
data <- read.table("household_power_consumption.txt",
                   header = TRUE, sep = ";", na.strings = "?",
                   skip = 66637, nrows = 2880, stringsAsFactors = FALSE)

# Add the colunm names
colnames(data) <- colnames(read.table("household_power_consumption.txt",
                                      header = TRUE, sep = ";", nrows = 1))

# Check if you got the correct data
head(data)

## Convert the Date and Time variables to proper Date/Time classes
## Even though we have already selected only the dates 2007-02-01 and 2007-02-02,
## it is still necessary to convert these columns so that R can understand them
## as actual time data instead of plain text.
##
## This conversion is important because:
## 1. The plots use time on the x-axis (e.g., minute-by-minute changes).
## 2. R needs the Date/Time variables in a recognized format (POSIXlt or POSIXct)
##    to correctly order and label the time axis.
## 3. Without this step, R would treat the Date and Time as character strings,
##    which would cause incorrect ordering and labeling of the plots.

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

## Plot 4 - 2x2 layout of multiple plots

Sys.setlocale("LC_TIME", "C")  # ensure English day labels

# Set 2x2 layout
par(mfrow = c(2, 2))

# 1) Top-left: Global Active Power
plot(data$DateTime, data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power",
     xaxt = "n", cex.axis = 0.8)
axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime) + 3600, by = "day"),
             format = "%a", cex.axis = 0.8)

# 2) Top-right: Voltage
plot(data$DateTime, data$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage",
     xaxt = "n", cex.axis = 0.8)
axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime) + 3600, by = "day"),
             format = "%a", cex.axis = 0.8)

# 3) Bottom-left: Energy sub metering
plot(data$DateTime, data$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering",
     col = "black", xaxt = "n", cex.axis = 0.8)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime) + 3600, by = "day"),
             format = "%a", cex.axis = 0.8)
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = 1, bty = "n", cex = 0.8)

# 4) Bottom-right: Global Reactive Power
plot(data$DateTime, data$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power",
     xaxt = "n", cex.axis = 0.8)
axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime) + 3600, by = "day"),
             format = "%a", cex.axis = 0.8)


## Create png

png("plot4.png", width = 480, height = 480)

Sys.setlocale("LC_TIME", "C")  # ensure English day labels

# Set 2x2 layout
par(mfrow = c(2, 2))

# 1) Top-left: Global Active Power
plot(data$DateTime, data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power",
     xaxt = "n", cex.axis = 0.8)
axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime) + 3600, by = "day"),
             format = "%a", cex.axis = 0.8)

# 2) Top-right: Voltage
plot(data$DateTime, data$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage",
     xaxt = "n", cex.axis = 0.8)
axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime) + 3600, by = "day"),
             format = "%a", cex.axis = 0.8)

# 3) Bottom-left: Energy sub metering
plot(data$DateTime, data$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering",
     col = "black", xaxt = "n", cex.axis = 0.8)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime) + 3600, by = "day"),
             format = "%a", cex.axis = 0.8)
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = 1, bty = "n", cex = 0.8)

# 4) Bottom-right: Global Reactive Power
plot(data$DateTime, data$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power",
     xaxt = "n", cex.axis = 0.8)
axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime) + 3600, by = "day"),
             format = "%a", cex.axis = 0.8)
dev.off()
