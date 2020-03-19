library(dplyr)
library(data.table)

if (!file.exists("HPC.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "HPC.zip")
    unzip(zipfile = "HPC.zip")    
}

setwd("./exdata_data_household_power_consumption/")

HPC <- fread("household_power_consumption.txt", stringsAsFactors = FALSE, na.strings = "?")
patterns <- c("^1/2/2007", "^2/2/2007")
HPC <- filter(HPC, grepl(paste(patterns, collapse = "|"), HPC$Date) )

HPC$dateTime <- strptime(paste(HPC$Date, HPC$Time, sep = " "), 
                         format = "%d/%m/%Y %H:%M:%S")

png("plot3.png", width=480, height=480)
#windows(width = 480, height = 480)
plot(x=HPC$dateTime, y=HPC$Sub_metering_1, type = "n", xlab = "", ylab = "Engery sub metering")
points(x=HPC$dateTime, y=HPC$Sub_metering_1, col="black", type = "l")
points(x=HPC$dateTime, y=HPC$Sub_metering_2, col="red", type = "l")
points(x=HPC$dateTime, y=HPC$Sub_metering_3, col="blue", type = "l")
legend("topright", col = c("black", "red", "blue"), lty = c(1, 1), lwd = c(1, 1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
