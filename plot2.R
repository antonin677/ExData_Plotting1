rm(list = ls())
library(tidyverse)

# Reading from household_power_consumption.txt file
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";") 

# Converting to date and time 
data$Time <- dmy_hms(paste(data$Date, data$Time))
data$Date <- with(data, dmy(Date))

# Subsetting the dates 2007-02-01 and 2007-02-02
data <- filter(data,
               Date == as.Date("2007-02-01") |
                   Date == as.Date("2007-02-02"))

# Replacing "?" with na values
data[-c(1, 2)] <- na_if(data[-c(1, 2)], "?")

# Converting characters to numeric
data <- mutate(data, across(where(is.character), as.numeric))

png("plot2.png")
with(data, plot(Time, 
     Global_active_power,
     type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)"))
dev.off()
