
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]
DT <- paste(data$Date, data$Time)
DT <- setNames(DT, "DT")
data <- data[ ,!(names(data) %in% c("Date","Time"))]
data <- cbind(DT, data)
data$DT <- as.POSIXct(DT)


par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
        plot(Global_active_power~DT, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~DT, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~DT, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DT,col='Red')
        lines(Sub_metering_3~DT,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~DT, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()