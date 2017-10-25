sourceDir <- getSrcDirectory(function(dummies) {dummies})
setwd(sourceDir)
if((any(grepl("xlsx",installed.packages())))==FALSE)
  install.packages("xlsx")
library(rJava)
library(xlsxjars)
library(xlsx)
data<-read.xlsx("SNACKS.xls",sheetIndex = 1,colIndex = c(1,2,3,4,5))
corr<-cor(data,use="complete.obs",method="spearman")
round(corr,2)
