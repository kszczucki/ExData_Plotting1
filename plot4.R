## Path to the directory containing the data sets
path <- "exdata-data-household_power_consumption/"

## URL for the zip file containing the data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Check to see if the data is already downloaded and unpacked.  
##  If not, create folder, download the file & unzip
if (!file.exists(path))  {
        dir.create("exdata-data-household_power_consumption/")
        download.file(fileURL, destfile = "exdata-data-household_power_consumption/exploratory1_dataset.zip")
        unzip("exdata-data-household_power_consumption/exploratory1_dataset.zip")
}


dataset <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
dataset3 <- filter(dataset, Date == '1/2/2007' | Date == '2/2/2007')
dataset3 <- dataset3 %>% mutate(datetime = paste(Date,Time)) %>% select(Global_active_power:datetime)
dataset3$datetime <- strptime(dataset3$datetime, "%d/%m/%Y %H:%M:%S")

#fourth plot
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(dataset3, plot(datetime,Global_active_power, type = "l"))
with(dataset3,plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
with(dataset3, plot(datetime, Sub_metering_1, type = "n", ylab="Energy sub metering", xlab=""))
with(dataset3, lines(datetime,Sub_metering_1, col = "black"))
with(dataset3, lines(datetime, Sub_metering_2, col = "red"))
with(dataset3, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright",lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(dataset3, plot(datetime, Global_reactive_power, type = "l"))
dev.off()