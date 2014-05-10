## load specific data from the text file and indicate missing value flag "?"
filename<-c("../household_power_consumption.txt")
lineflag<-grep("^[1-2]/2/2007", readLines(file(filename)))
tmp.header<-strsplit(readLines(file(filename), n=1), split=";")
hpConsumption<-read.table(filename, header=F, sep=";", na.strings="?", 
                          skip=lineflag[[1]]-1, nrows=length(lineflag), 
                          col.names=unlist(tmp.header))

## output a png file with a hist plot
png(filename="plot1.png", width=480, height=480, units="px", bg="transparent")
hist(hpConsumption$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()