library("data.table")


#data Clean up and create data Data object
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
data[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#filter 2-day period in February, 2007
data2days <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]


png("plots/plot2.png", width=480, height=480)

## Plot 2
plot(x = data2days[, dateTime]
     , y = data2days[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()