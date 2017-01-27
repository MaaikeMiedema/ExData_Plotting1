## Plots line plot of Sub meterings to PNG-file
##
## Data in ./data/household_power_consumption.txt
## Derived Jan 26 from: 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## Info on data: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
##
## REMARK: in order to obtain "Thu", "Fri", "SAT" as X-labels I had to change
## the "date language"in Windows 
##
## Data downloaded by: (subdirectory data of working directory exists)
#  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#  filepath <- file.path(getwd(),"/data/EDAproject.zip")
#  download.file(url,filepath)
#  unzip ("./data/EDAproject.zip", exdir="./data")
#  file.remove("./data/EDAproject.zip")

library("data.table")
library("dplyr")

## READ DATA
allData<-fread("./data/household_power_consumption.txt",header=TRUE,sep=";",
                    na.strings="?" )

## SUBSET DATA of FEB 1 AND FEB2 2007
myData<-filter(allData,Date=="1/2/2007"|Date=="2/2/2007")
rm(allData)

## CONVERT VARIABLE TYPES Date AND Time FROM CHARACTER TO DATE/TIME 
myData$Date<-gsub(pattern="1/2/2007", replacement="01/02/2007", myData$Date)
myData$Date<-gsub(pattern="2/2/2007", replacement="02/02/2007", myData$Date)
myData$DateTime<-paste (myData$Date,myData$Time)
myData$DateTime<-strptime(myData$DateTime,"%d/%m/%Y %H:%M:%S")

## HISTOGRAM TO PNG-file
png(filename = "plot3.png", width = 480, height = 480)
with (myData, plot(DateTime,Sub_metering_1, type="l", xlab="",
                   ylab="Energy sub metering"))
with (myData, lines(DateTime,Sub_metering_2, lty=1, col="red"))
with (myData, lines(DateTime,Sub_metering_3, lty=1, col="blue"))
legend("topright",lty=1, col=c("black","red", "blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

## MESSAGE TO CONSOLE
print("Script has run correctly:")
print(paste("plot3.png written to", as.character(getwd())))

