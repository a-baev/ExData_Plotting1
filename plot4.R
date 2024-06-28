library(lubridate)
library(sqldf)


setwd('C:\\Users\\baev\\Desktop\\Ecopsy\\03 R\\04 R Programming (p.2)\\20240628 Course Project 1\\ExData_Plotting1')

#loading required columns of data set from csv-file: 
df <- read.csv.sql(file = "household_power_consumption.txt", 
                   sep = ";",
                   header = TRUE,
                   sql = "SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007') ")

# Data information:
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

head(df)
dim(df)
str(df)

#Checking NA values (marked as "?")
sum(df=='?') #0 - There are no NA's

#Creating DateTime column 
df$DateTime <- paste(df$Date, df$Time, sep = ' ')
#Converting DateTime column content to class "POSIXct" format
df$DateTime <- dmy_hms(df$DateTime)
# Dropping Date and Time columns and сhanging the order of columns
df <- df[-c(1,2)]
df <- df[c(8,1:7)]
str(df)

# checking current graphical device
dev.cur()


# plotting to the screen

par(mfcol = c(2,2))

hist(x = df$Global_active_power, xlab = 'Global Active Power (kilowatts)', ylab = "Frequency", col = 'red', main = 'Global Active Power')

plot(x = df$DateTime, y = df$Global_active_power,  xlab = '', ylab = 'Global Active Power (kilowatts)', main = '', type = 'n', frame.plot = T, axes = F)
lines(x = df$DateTime, y = df$Global_active_power)
axis(side = 1, labels = c('Thu', 'Fri', 'Sat'),  at=c(min(df$DateTime),min(df$DateTime)+days(1), min(df$DateTime)+days(2)))
axis(side = 2)
    
plot(x = df$DateTime, y = df$Voltage,  xlab = 'datetime', ylab = 'Voltage', main = '', type = 'n', frame.plot = T, axes = F)
axis(side = 1, labels = c('Thu', 'Fri', 'Sat'),  at=c(min(df$DateTime),min(df$DateTime)+days(1), min(df$DateTime)+days(2)))
axis(side = 2, )
lines(x = df$DateTime, y = df$Voltage, col = 'black')

plot(x = df$DateTime, y = df$Global_reactive_power,  xlab = 'datetime', ylab = 'Global_reactive_power', main = '', type = 'n', frame.plot = T, axes = F)
axis(side = 1, labels = c('Thu', 'Fri', 'Sat'),  at=c(min(df$DateTime),min(df$DateTime)+days(1), min(df$DateTime)+days(2)))
axis(side = 2, )
lines(x = df$DateTime, y = df$Global_reactive_power, col = 'black')


#plotting to plot4.png
png(filename = 'plot4.png', width = 480, height = 480, units = 'px')

par(mfcol = c(2,2))

plot(x = df$DateTime, y = df$Global_active_power,  xlab = '', ylab = 'Global Active Power (kilowatts)', main = '', type = 'n', frame.plot = T, axes = F)
lines(x = df$DateTime, y = df$Global_active_power)
axis(side = 1, labels = c('Thu', 'Fri', 'Sat'),  at=c(min(df$DateTime),min(df$DateTime)+days(1), min(df$DateTime)+days(2)))
axis(side = 2)

plot(x = df$DateTime, y = df$Sub_metering_1,  xlab = '', ylab = 'Energy sub metering', main = '', type = 'n', frame.plot = T, axes = F)
axis(side = 1, labels = c('Thu', 'Fri', 'Sat'),  at=c(min(df$DateTime),min(df$DateTime)+days(1), min(df$DateTime)+days(2)))
axis(side = 2)
lines(x = df$DateTime, y = df$Sub_metering_1, col = 'black')
lines(x = df$DateTime, y = df$Sub_metering_2, col = 'red')
lines(x = df$DateTime, y = df$Sub_metering_3, col = 'blue')
legend('topright',
       lty = 1,
       col = c('black', 'red', 'blue'), 
       legend = names(df[6:8]))

plot(x = df$DateTime, y = df$Voltage,  xlab = 'datetime', ylab = 'Voltage', main = '', type = 'n', frame.plot = T, axes = F)
axis(side = 1, labels = c('Thu', 'Fri', 'Sat'),  at=c(min(df$DateTime),min(df$DateTime)+days(1), min(df$DateTime)+days(2)))
axis(side = 2, )
lines(x = df$DateTime, y = df$Voltage, col = 'black')

plot(x = df$DateTime, y = df$Global_reactive_power,  xlab = 'datetime', ylab = 'Global_reactive_power', main = '', type = 'n', frame.plot = T, axes = F)
axis(side = 1, labels = c('Thu', 'Fri', 'Sat'),  at=c(min(df$DateTime),min(df$DateTime)+days(1), min(df$DateTime)+days(2)))
axis(side = 2, )
lines(x = df$DateTime, y = df$Global_reactive_power, col = 'black')

dev.off()