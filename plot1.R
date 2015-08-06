#'
#' Main function
#'
go <- function(){  
  data = loadData('household_power_consumption.txt')
  drawPlot1OnPng(data)
}

#'
#' Read the file and filter the data
#'
loadData <- function(fileName){
  library(sqldf)
  data = read.csv.sql(fileName, 
                      sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header = TRUE, sep = ';')
  data
}

#'
#' Draw the histogram into a PNG file
#'
drawPlot1OnPng <- function(data){
  png(filename='plot1.png', width=480, height=480, units='px')
  hist(data$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
  dev.off()
}