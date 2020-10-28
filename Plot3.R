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
date_time <- paste(sub_data$Date, sub_data$Time)
date_time <- strptime(date_time, "%Y-%m-%d %H:%M:%S")
sub_metering_1<-as.numeric(sub_data$Sub_metering_1)
sub_metering_2<-as.numeric(sub_data$Sub_metering_2)
sub_metering_3<-as.numeric(sub_data$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(date_time, sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(date_time, sub_metering_1, col="black")
lines(date_time, sub_metering_2, col="red")
lines(date_time, sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
