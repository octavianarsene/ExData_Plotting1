#'
#' Main function
#'
go <- function(){  
  data = loadData('household_power_consumption.txt')
  drawPlot3OnPng(data)
}

#'
#' Read the file and filter the data
#'
loadData <- function(fileName){
  library(sqldf)
  data = read.csv.sql(fileName, 
                      sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header = TRUE, sep = ';')
  #' Date format for: 1/2/2007 00:01:00
  DATE_TIME_FORMAT = '%d/%m/%Y %H:%M:%S'
  data$DateTime=as.POSIXct(paste(data$Date, data$Time, sep=' '), format=DATE_TIME_FORMAT)
  
  data
}

#'
#' Draw the multiple line graphs into a PNG file
#'
drawPlot3OnPng <- function(data){
  png(filename='plot3.png', width=480, height=480, units='px')
  plot(data$Sub_metering_1~data$DateTime, type="l",
       xlab='', ylab='Energy sub metering',
       col="black")
  lines(data$Sub_metering_2~data$DateTime, col='red')
  lines(data$Sub_metering_3~data$DateTime, col='blue')
  legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
         col=c('black','red','blue'), lwd=2, lty=1)
  dev.off()
}