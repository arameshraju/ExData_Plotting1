library("data.table")


#data Clean up and create data Data object
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
data[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#filter 2-day period in February, 2007
data2days <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]


png("plots/plot3.png", width=480, height=480)

## Plot 3
plot(data2days[, dateTime], data2days[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(data2days[, dateTime], data2days[, Sub_metering_2],col="red")
lines(data2days[, dateTime], data2days[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()