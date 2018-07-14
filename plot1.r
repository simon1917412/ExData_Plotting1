#Download and Unzip DataSet
if(!file.exists("./week1 project")){dir.create("./week1 project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./week1 project/Dataset.zip")

unzip(zipfile="./week1 project/Dataset.zip",exdir="./week1 project")

#Read in Power Consumption Data, Format and Subset as necessary
PCD <- read.table("./week1 project/household_power_consumption.txt",sep=";",header = TRUE)

PCD$Date<-as.Date(PCD$Date, format = "%d/%m/%Y")
PCD$Global_active_power<-as.numeric(as.character((PCD$Global_active_power)))

SubPCD<- subset(PCD, Date == "2007-02-01" | Date == "2007-02-02")

#Construct Plot

png("plot1.png", width=480, height=480)
hist(SubPCD$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()




