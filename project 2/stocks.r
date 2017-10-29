options(java.parameters = "- Xmx1024m")
sourceDir <- getSrcDirectory(function(dummy) {dummy})
setwd(sourceDir)
if((any(grepl("xlsx",installed.packages())))==FALSE)
  install.packages("xlsx")

library(rJava)
library(xlsxjars)
library(xlsx)
data<- read.xlsx("STOCKS.xlsx",sheetIndex = 1,colIndex = c(match('A',LETTERS),match('C',LETTERS)))
data_store<-data
data<-data_store
data<-data[complete.cases(data),]
check<-data[,sapply(data,is.numeric)]
data<-aggregate(check,list(date=data$Date),mean)

plot(data)

AR_Model<-ar(data,method="yule-walker")
print(AR_Model)
