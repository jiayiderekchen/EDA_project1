#4

data_full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

data <- subset(data_full, data_full$Date <= "2007-02-02" & data_full$Date >= "2007-02-01")
rm(data_full)

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)




par(mfrow =c(2,2))
with(data, {
        plot(Global_active_power~Datetime,type = "l",xlab = "", ylab = "Global Active Power")
        plot(Voltage~Datetime, type="l",xlab="datetime",ylab="Voltage")
        plot(Sub_metering_1 ~Datetime, type="l",ylab = "Energy Sub Metering", xlab="")
        lines(Sub_metering_2 ~Datetime, col="red" )
        lines(Sub_metering_3 ~Datetime, col="blue" )
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime,type="l",xlab="datetime")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()