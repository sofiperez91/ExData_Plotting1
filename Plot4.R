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
sub_metering_1<-as.numeric(sub_data$Sub_metering_1)
sub_metering_2<-as.numeric(sub_data$Sub_metering_2)
sub_metering_3<-as.numeric(sub_data$Sub_metering_3)
voltage<-as.numeric(sub_data$Voltage)
reactive<-as.numeric(sub_data$Global_reactive_power)


png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(date_time, power, type="l", xlab="", ylab="Global Active Power")
plot(date_time, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(date_time, sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  lines(date_time, sub_metering_1, col="black")
  lines(date_time, sub_metering_2, col="red")
  lines(date_time, sub_metering_3, col="blue")
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(date_time, reactive, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
