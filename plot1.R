library(tidyverse)

if (!file.exists("HPC.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "HPC.zip")
    unzip(zipfile = "HPC.zip")    
}

setwd("./exdata_data_household_power_consumption/")

HPC <- fread("household_power_consumption.txt", stringsAsFactors = FALSE)
#patterns <- c("1/2/2007", "2/2/2007")
#HPC <- filter(HPC, grepl(paste(patterns, collapse = "|"), HPC$Date) )
#HPC$Time <- strptime(paste(HPC$Date, HPC$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
HPC$Date <- as.Date(HPC$Date, format = "%d/%m/%Y")
HPC <- filter(HPC, HPC$Date == "2007-02-01" | HPC$Date == "2007-02-02")
HPC[, c(3:8)] <- sapply(HPC[, c(3:8)], as.numeric)
    
HPCClean1 <- HPC[!is.na(HPC$Global_active_power), ]

hist(HPCClean1$Global_active_power, col = "red", 
     xlab = "Global Active Power (Kilowatts)", 
     ylab = "Frequency", main = "Global Active Power")

HPCClean1 <- transform(HPCClean1, Day = factor(weekdays(HPC$Date)))
#plot(HPCClean1$Global_active_power ~ Day, HPCClean1, 
        xlab = "Day", ylab = "Global Active Power (Kilowatts)")
#plot(HPCClean1$Global_active_power ~ HPCClean1$Time, HPCClean1, 
     xlim = range(HPCClean1$Time), ylim=range(HPCClean1$Global_active_power),
     xlab = "Day", ylab = "Global Active Power (Kilowatts)")
plot(HPCClean1$Time, HPCClean1$Global_active_power, HPCClean1, 
     type = "l", xlab = "Day", ylab = "Global Active Power (Kilowatts)")
