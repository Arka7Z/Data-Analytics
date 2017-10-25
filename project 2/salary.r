options(java.parameters = "- Xmx1024m")
sourceDir <- getSrcDirectory(function(dummies) {dummies})
setwd(sourceDir)
if((any(grepl("xlsx",installed.packages())))==FALSE)
  install.packages("xlsx")


library(rJava)
library(xlsxjars)
library(xlsx)
data<-read.xlsx("SALARY.xlsx",sheetIndex=1,colIndex = c(match('D',LETTERS),match('E',LETTERS),match('F',LETTERS),match('G',LETTERS),match('J',LETTERS)))
data<-data[data$Year==2014,]
corr_basepay_overtime<-cor(as.numeric(as.character(data$OvertimePay)),as.numeric(as.character(data$BasePay)),use="complete.obs",method="pearson")
corr_basepay_otherpay<-cor(as.numeric(as.character(data$OtherPay)),as.numeric(as.character(data$BasePay)),use="complete.obs",method="pearson")
corr_basepay_benefits<-cor(as.numeric(as.character(data$Benefits)),as.numeric(as.character(data$BasePay)),use="complete.obs",method="pearson")
cat("Correlation between basepay and otherpay is",corr_basepay_otherpay,"\n")
cat("Correlation between basepay and Overtime is",corr_basepay_overtime,"\n")
cat("Correlation between basepay and benefits is",corr_basepay_benefits,"\n")
cat("Since all the correlation coefficients are positive therefore we can conclude that all the entities increase with Base pay in the year 2014\n")
