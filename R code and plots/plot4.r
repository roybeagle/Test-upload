fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=fileUrl,destfile = "exdata-data-household_power_consumption.zip")  
unzip("exdata-data-household_power_consumption.zip")
df<-read.table("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors = FALSE)

df$strpdate<-strptime(df$Date,"%d/%m/%Y")
feb2<-subset(df,(strpdate=="2007-02-01") | (strpdate==("2007-02-02")) )
dim(feb2)
feb2$DateTime <- strptime(paste(feb2$Date, feb2$Time), "%d/%m/%Y %H:%M:%S") 
for (x in 3:9){feb2[names(df)[x]]<-as.numeric(feb2[,x])}

one<-ggplot(data=feb2, aes(x=DateTime, y=as.numeric(Global_active_power), group=1))+ylab("Global Active Power (kilowatts)")+
  xlab("")+geom_line(colour="black", size=.5)+theme(panel.background = element_rect(fill = 'white', colour = 'black'))

one2<-ggplot(data=feb2, aes(x=DateTime, y=Voltage, group=1))+ylab("Voltage")+
  xlab("datetime")+geom_line(colour="black", size=.5)+
  theme(panel.background = element_rect(fill = 'white', colour = 'black'))

three<-ggplot(feb)+geom_line(aes(x=DateTime,y=value,colour=variable))+
  scale_colour_manual(values=c("black","red","blue"))+xlab("")+ylab("Energy sub metering")

two1<-three+theme(legend.title=element_blank(),legend.position = c(0.85,.8),
            panel.background = element_rect(fill = 'white', colour = 'black'))

two2<-ggplot(data=feb2, aes(x=DateTime, y=Global_reactive_power, group=1))+ylab("GLobal_reactive_power")+
  xlab("datetime")+geom_line(colour="black", size=.5)+
  theme(panel.background = element_rect(fill = 'white', colour = 'black'))

library(gridExtra)
png(filename="plot4.png")
grid.arrange(one,one2,two1,two2)
dev.off()