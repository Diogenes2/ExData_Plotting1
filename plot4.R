hpc <- read.csv("household_power_consumption.txt", sep = ";")
hpcdates<- hpc$Date
hpcdateschars <- sapply(hpcdates, as.character)
hpcdatelist <- lapply(hpcdateschars, as.Date, format = "%d/%m/%Y")
df <- as.data.frame(hpcdatelist)
trans <- t(df)
dated <- cbind(hpc, trans)
library("lubridate")
sdt <- subset.data.frame(dated, year(trans) == 2007)
smallest <- subset.data.frame(sdt, month(trans) == 2)
day1 <- subset.data.frame(smallest, day(trans) == 1)
day2 <- subset.data.frame(smallest, day(trans) == 2)
shrunkdt <- rbind.data.frame(day1, day2)
prettydf <- shrunkdt[,2:10]
prettydf<- transform(prettydf, dati=as.POSIXct(paste(trans, Time)), "%d/%m/%Y %H:%M:%S")
prettydf$Sub_metering_1 <- as.numeric(as.character(prettydf$Sub_metering_1))
prettydf$Sub_metering_2 <- as.numeric(as.character(prettydf$Sub_metering_2))
prettydf$Sub_metering_3 <- as.numeric(as.character(prettydf$Sub_metering_3))
prettydf$Voltage <- as.numeric(as.character(prettydf$Voltage))
prettydf[,2] <- as.numeric(as.character(prettydf[,2]))
prettydf[,3] <- as.numeric(as.character(prettydf[,3]))
par(mfrow=c(2,2))
plot(prettydf$dati, prettydf$Global_active_power, type = "line", ylab = "Global Active Power", xlab = "")
plot(prettydf$dati, prettydf$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(prettydf$dati, prettydf$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(prettydf$dati, prettydf$Sub_metering_2, type = "l", col = "red")
points(prettydf$dati, prettydf$Sub_metering_3, type = "l", col = "blue")
plot(prettydf$dati, prettydf$Global_reactive_power, type = "l", ylab="Global_reactive_power", xlab="datetime")
dev.copy(png,"plot4.png",width=480,height=480,units="px",res=100)
dev.off()