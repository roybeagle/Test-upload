fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=fileUrl,destfile = "exdata-data-household_power_consumption.zip")  
unzip("exdata-data-household_power_consumption.zip")
df<-read.table("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors = FALSE)
library(ggplot2)
df$strpdate<-strptime(df$Date,"%d/%m/%Y")
feb2<-subset(df,(strpdate=="2007-02-01") | (strpdate==("2007-02-02")) )
dim(feb2)
feb2$DateTime <- strptime(paste(feb2$Date, feb2$Time), "%d/%m/%Y %H:%M:%S") 
for (x in 3:9){feb2[names(df)[x]]<-as.numeric(feb2[,x])}

png(filename="plot2.png")
ggplot(data=feb2, aes(x=DateTime, y=as.numeric(Global_active_power), group=1))+ylab("Global Active Power (kilowatts)")+
  xlab("")+geom_line(colour="black", size=.5)+theme(panel.background = element_rect(fill = 'white', colour = 'black'))
dev.off()