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
prettydf[,2] <- as.numeric(as.character(prettydf[,2]))
hist(prettydf[,2], col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png,"plot1.png",width=480,height=480,units="px",res=100)
dev.off()

