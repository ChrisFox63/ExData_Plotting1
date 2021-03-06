## load specific data from the text file and indicate missing value flag "?"
filename<-c("../household_power_consumption.txt")
lineflag<-grep("^[1-2]/2/2007", readLines(file(filename)))
tmp.header<-strsplit(readLines(file(filename), n=1), split=";")
hpConsumption<-read.table(filename, header=F, sep=";", na.strings="?", 
                          skip=lineflag[[1]]-1, nrows=length(lineflag), 
                          col.names=unlist(tmp.header))

## combine Date and Time to a new variable in POSIXlt format
hpConsumption$datetime<-strptime(paste(hpConsumption$Date,hpConsumption$Time),
                                 "%d/%m/%Y %H:%M:%S")

## define plot3 style
plotColName<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plotColor<-c("black", "red", "blue")
plotType<-rep("solid", 3)

## output a png file with a hist plot
png(filename="plot4.png", width=480, height=480, units="px", bg="transparent")
par(mfrow=c(2,2))
## plot1
with(hpConsumption, plot(datetime, Global_active_power, ann=F, type="l"))
title(ylab="Global Active Power")
## plot2
with(hpConsumption,plot(datetime, Voltage, type="l"))
## plot3
plot(hpConsumption$datetime, hpConsumption[[plotColName[1]]], ann=F, type="l", 
     col=plotColor[1])
lines(hpConsumption$datetime, hpConsumption[[plotColName[2]]], col=plotColor[2])
lines(hpConsumption$datetime, hpConsumption[[plotColName[3]]], col=plotColor[3])
title(ylab="Energy sub metering")
legend("topright", legend=plotColName, col=plotColor, lty=plotType, bty="n")
## plot4
with(hpConsumption, plot(datetime, Global_reactive_power, type="l"))
dev.off()