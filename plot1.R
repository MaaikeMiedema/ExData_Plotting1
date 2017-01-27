## Plots histogram of Global Active Power to PNG-file
##
## Data in ./data/household_power_consumption.txt
## Derived Jan 26 from: 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## Info on data: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

library ("dplyr")

## DOWNLOAD DATA
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filepath <- file.path(getwd(),"/data/EDAproject.zip")
download.file(url,filepath)
unzip ("./data/EDAproject.zip", exdir="./data")
file.remove("./data/EDAproject.zip")

## READ DATA
allData<-read.table("./data/household_power_consumption.txt",header=TRUE,sep=";",
                    na.strings="?" )

##SUBSET DATA of FEB 1 AND FEB2 2007
myData<-filter(allData,Date=="1/2/2007"|Date=="2/2/2007")
rm(allData)

## HISTOGRAM TO PNG-file
png(filename = "plot1.png", width = 480, height = 480)
hist(myData$Global_active_power,xlab="Global Active Power (kilowatts)", 
     main= "Global Active Power",col="red")
dev.off()

## MESSAGE TO CONSOLE
print("Script has run correctly:")
print(paste("plot1.png written to", as.character(getwd())))



