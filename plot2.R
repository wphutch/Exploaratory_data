#
#  Set working directory
#
wd <- getwd()
setwd("Exploratory data analysis")
setwd("exdata_data_household_power_consumption")
#
# Read input file.  
#
x<-read.table("household_power_consumption.txt", sep=";", header=TRUE, 
              na.strings = "?", nrows=2100000)
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
our_date <- mutate(our_date, 
                   Date_time = dmy_hms(paste(our_date$Date, our_date$Time, sep=" ")))
#
#  Build the required table and save it to a png file.
#
with(our_date, 
     plot(Date_time, Global_active_power, xlab=" ",
          ylab="Global Active Power (kilowatts)", type ="l"))
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()
#
#  Reset working directory
#
setwd(wd)
