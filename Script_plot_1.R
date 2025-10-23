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

## Plot 1 - Histogram of Global Active Power

hist(data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

## Save the plot to a PNG file
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
