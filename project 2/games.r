options(java.parameters = "- Xmx1024m")
sourceDir <- getSrcDirectory(function(dummies) {dummies})
setwd(sourceDir)
if((any(grepl("xlsx",installed.packages())))==FALSE)
  install.packages("xlsx")
library(rJava)
library(xlsxjars)
library(xlsx)
data<-read.xlsx("GAMES.xlsx",sheetIndex=1,colIndex=c(match('D',LETTERS),match('P',LETTERS)))
data<-data[complete.cases(data),]
rating<-levels(data$Genre)[levels(data$Genre)!="Action"]<-"Not-Action"
category<-levels(data$Rating)[levels(data$Rating)!="T"]<-"Not Teen"
contigency_table<-table(data$Rating,data$Genre)
print(contigency_table)
cat("chi-square test\n")
print(chisq.test(contg_table))#hypothesis no correlation if alpha=0.1 discard hypothesis for alpha =0.05 retain
