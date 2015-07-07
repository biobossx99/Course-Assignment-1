#Exploratory Data Analysis Assignment 1 - Coursera
#Plot 2
#Allen Seol 

#Packages Used - dplyr
#install.packages("dplyr")
#library("dplyr")

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

#Converting Global_active_power from factor to integer
power5 <- mutate(power5, Global_active_power = as.numeric(as.character(power5$Global_active_power)))
          

#Exporting to Graphic Device
png(file = "plot2.png", width = 480, height = 480)

#Making Line Plot
with(power5, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))

#dev off
dev.off()