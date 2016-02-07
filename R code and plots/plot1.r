fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=fileUrl,destfile = "exdata-data-household_power_consumption.zip")  
unzip("exdata-data-household_power_consumption.zip")
df<-read.table("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors = FALSE)

df$strpdate<-strptime(df$Date,"%d/%m/%Y")
feb2<-subset(df,(strpdate=="2007-02-01") | (strpdate==("2007-02-02")) )
dim(feb2)
feb2$DateTime <- strptime(paste(feb2$Date, feb2$Time), "%d/%m/%Y %H:%M:%S") 
for (x in 3:9){feb2[names(df)[x]]<-as.numeric(feb2[,x])}

hist(as.numeric(feb2$Global_active_power),col="red",
          xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")

png(filename="plot1.png")
hist(as.numeric(feb2$Global_active_power),col="red",
     xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")
dev.off()
