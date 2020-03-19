library(dplyr)
library(data.table)
library(lubridate)

if (!file.exists("HPC.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "HPC.zip")
    unzip(zipfile = "HPC.zip")    
}

setwd("./exdata_data_household_power_consumption/")

HPC <- fread("household_power_consumption.txt", stringsAsFactors = FALSE, na.strings = "?")
patterns <- c("^1/2/2007", "^2/2/2007")
HPC <- filter(HPC, grepl(paste(patterns, collapse = "|"), HPC$Date) )

#HPC$dateTime <- strptime(paste(HPC$Date, HPC$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
HPC$dateTime <- as.POSIXct(paste(HPC$Date, HPC$Time, sep =" "), 
                           format = "%d/%m/%Y %h:%m:%s")
#HPC$dateTime <- mutate()
#HPC$Date <- as.Date(HPC$Date, format = "%d/%m/%Y")
#HPC <- filter(HPC, HPC$dateTime >= "2007-02-01" & HPC$dateTime <= "2007-02-03")

#HPC[, c(3:8)] <- sapply(HPC[, c(3:8)], as.numeric)

HPCClean1 <- HPC[!is.na(HPC$Global_active_power), ]

png("plot2.png", width=480, height=480)
plot(HPCClean1$dateTime, HPCClean1$Global_active_power, HPCClean1, 
     xlim = range(HPCClean1$dateTime), ylim = range(HPCClean1$Global_active_power),
         type = "l", xlab = "Day", ylab = "Global Active Power (Kilowatts)")
dev.off()
