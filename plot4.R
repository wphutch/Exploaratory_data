#
#  Set working directory
#
wd <- getwd()
setwd("Exploratory data analysis")
setwd("exdata_data_household_power_consumption")
#
# Read input file.  
#
x<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", nrows=2100000)
#
#  Load libraries we will need
#
library(dplyr)
library(lubridate)
#
#  Retain only the dates we will need.  This cuts the file from ~2.1 million rows to 2880 rows.
#
our_date <- filter(x, Date=="1/2/2007" | Date=="2/2/2007")
#
#  Change the dates and times from character strings to a date-time variable in 3 steps.
#  Paste concatenates the date to the time with a space between them;
#  dmy_hms computes the date and time from the concatenated character string; and
#  Mutate adds the field called Date_time to the table.
#
our_date <- mutate(our_date, Date_time = dmy_hms(paste(our_date$Date, our_date$Time, sep=" ")))
#
#  Specify that we want a 2x2 grid of plotss.
#
par(mfrow = c(2, 2))
#
#  Build the upper Left plot
#
with(our_date, 
     plot(Date_time, Global_active_power, ylab="Global Active Power (kilowatts)", 
          xlab=" ", type ="l"))
#
#  Build the lower left plot
#
with(our_date, 
     plot(Date_time, Voltage, ylab="Voltage", type ="l", xlab="datetime"))
#
#  Build the upper right plot in 4 steps
#  Use Plot to build the first line
#  Use Lines to add the second and third lines.
#  Place the legend in with the Legend command.
#
plot(our_date$Date_time, our_date$Sub_metering_1, ylab="Energy sub metering", 
     xlab=" ",type ="l", col="black")
lines(our_date$Date_time, our_date$Sub_metering_2, type ="l", col="red",xlab=" ")
lines(our_date$Date_time, our_date$Sub_metering_3, type ="l", col="blue",xlab=" ")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"), 
      col=c("black","red","blue"), ncol=1, lty=c(1,1,1), border="white")
#
# Build the lower right plot
#
plot(our_date$Date_time, our_date$Global_reactive_power, ylab="Global_reactive_power", 
          type ="l", xlab="datetime")
#
#  Copy the graph to a png file.  When I tried to size it as 480x480 as 
#  the assignment said, the legend was truncated.  
#
dev.copy(png, file = "plot4.png", width=520, height=480)
dev.off()
#
#  Reset working directory
#
setwd(wd)