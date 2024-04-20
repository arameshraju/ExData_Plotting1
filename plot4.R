library("data.table")


#data Clean up and create data Data object
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
data[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#filter 2-day period in February, 2007
data2days <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]


png("plots/plot4.png", width=480, height=480)
## setup as 2/2
par(mfrow=c(2,2))

## plot 1

hist(data2days[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Plot 2
plot(x = data2days[, dateTime]
     , y = data2days[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Plot 3
plot(data2days[, dateTime], data2days[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(data2days[, dateTime], data2days[, Sub_metering_2],col="red")
lines(data2days[, dateTime], data2days[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

## Plot 4
plot(data2days[, dateTime], data2days[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()