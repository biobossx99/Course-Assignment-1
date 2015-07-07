#Exploratory Data Analysis Assignment 1 - Coursera
#Plot 3
#Allen Seol 

#Packages Used - dplyr
library("dplyr")

#Loading Data
power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Converting to TBL Dataframe (working copy)
power2 <- tbl_df(power)

#Converting Time/Date into correct classes
power2 <- mutate(power2, Date = as.Date(power2$Date, format ="%d/%m/%Y"))
power2 <- mutate(power2, Time = paste(power2$Date,power2$Time))
power2 <- mutate(power2, Time = as.POSIXct(power2$Time,format = "%Y-%m-%d %H:%M:%S"))

#Subsetting Into 2007-02-01 and 2007-02-02 Dates and combing into Power5
power3 <- filter(power2, Date == as.Date("2007-02-01")) 
power4 <- filter(power2, Date == as.Date("2007-02-02"))
power5 <- bind_rows(power3,power4)

#Converting Important Variables from factor to integer
power5 <- mutate(power5, Global_active_power = as.numeric(as.character(power5$Global_active_power)))
power5 <- mutate(power5, Sub_metering_1 = as.numeric(as.character(power5$Sub_metering_1)))
power5 <- mutate(power5, Sub_metering_2 = as.numeric(as.character(power5$Sub_metering_2)))
power5 <- mutate(power5, Sub_metering_3 = as.numeric(as.character(power5$Sub_metering_3)))

#Exporting to Graphic Device
png(file = "plot3.png", width = 480, height = 480)

#plotting components with legend
with(power5, plot(Time,Sub_metering_1,type = "l", ylab = "Energy sub metering"), type ="n")
with(power5, lines(Time,Sub_metering_2,col ="red"))
with(power5, lines(Time,Sub_metering_3,col="blue"))
legend("topright",lty = c(1,1,1),col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#dev off
dev.off()