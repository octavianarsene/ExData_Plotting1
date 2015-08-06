#'
#' Main function
#'
go <- function(){  
  data = loadData('household_power_consumption.txt')
  drawPlot2OnPng(data)
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
#' Draw the line graph into a PNG file
#'
drawPlot2OnPng <- function(data){
  png(filename='plot2.png', width=480, height=480, units='px')
  plot(data$Global_active_power~data$DateTime, type="l",
       xlab='', ylab='Global Active Power (kilowatts)',
       col="black")
  dev.off()
}