#Download and Unzip DataSet
if(!file.exists("./week1 project")){dir.create("./week1 project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./week1 project/Dataset.zip")

unzip(zipfile="./week1 project/Dataset.zip",exdir="./week1 project")

#Read in Power Consumption Data, Format and Subset as necessary
PCD <- read.table("./week1 project/household_power_consumption.txt",sep=";",header = TRUE)

PCD$Date<-as.Date(PCD$Date, format = "%d/%m/%Y")
PCD$Time <- format(PCD$Time, format="%H:%M:%S")

SubPCD<- subset(PCD, Date == "2007-02-01" | Date == "2007-02-02")


SubPCD$datetime <- strptime(paste(SubPCD$Date, SubPCD$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
SubPCD$Sub_metering_1<-as.numeric(as.character((SubPCD$Sub_metering_1)))
SubPCD$Sub_metering_2<-as.numeric(as.character((SubPCD$Sub_metering_2)))
SubPCD$Sub_metering_3<-as.numeric(as.character((SubPCD$Sub_metering_3)))
SubPCD$Global_active_power<-as.numeric(as.character((SubPCD$Global_active_power)))
SubPCD$Global_reactive_power<-as.numeric(as.character((SubPCD$Global_reactive_power)))
SubPCD$Voltage<-as.numeric(as.character((SubPCD$Voltage)))

#Construct Plot

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(SubPCD$datetime, SubPCD$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(SubPCD$datetime, SubPCD$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(SubPCD$datetime, SubPCD$Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering")
lines(SubPCD$datetime, SubPCD$Sub_metering_2,type="l", col= "red")
lines(SubPCD$datetime, SubPCD$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))

plot(SubPCD$datetime, SubPCD$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

