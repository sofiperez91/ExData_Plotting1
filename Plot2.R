#Download project files

if (!file.exists("Project_Files.zip")){
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile="./Project_Files.zip",method="curl")
}
if (!file.exists("household_power_consumption.txt")){
  unzip("./Project_Files.zip")
}

data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
data$Date <- as.Date(data$Date,"%d/%m/%Y")
sub_data <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")
power <- as.numeric(sub_data$Global_active_power)
date_time <- paste(sub_data$Date, sub_data$Time)
date_time <- strptime(date_time, "%Y-%m-%d %H:%M:%S")
png("plot2.png", width=480, height=480)
plot(date_time, power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()