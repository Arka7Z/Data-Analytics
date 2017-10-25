sourceDir <- getSrcDirectory(function(dummies) {dummies})
setwd(sourceDir)
if((any(grepl("xlsx",installed.packages())))==FALSE)
  install.packages("xlsx")
library(rJava)
library(xlsxjars)
library(xlsx)
data<-read.xlsx("MOVIE.xlsx",sheetIndex=1)
data<-data[2:nrow(data),]

data_2015<-data[data$Column.25<=2015]
