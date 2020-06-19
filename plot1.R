#
#  Set working directory
#
wd <- getwd()
setwd("Exploratory data analysis")
setwd("exdata_data_household_power_consumption")
#
# Read input file.  
#
x<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", 
              nrows=2100000)
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
# Build plot 1 and save it to a png file.
hist(our_date$Global_active_power, col = "red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()
#
#  Reset working directory
#
setwd(wd)