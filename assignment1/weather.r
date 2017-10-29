sourceDir <- getSrcDirectory(function(dummies) {dummies})
setwd(sourceDir)
if((any(grepl("xlsx",installed.packages())))==FALSE)
  install.packages("xlsx")
library(rJava)
library(xlsxjars)
library(xlsx)
df<-data.frame()
for (x in 1:56) 
  df <- rbind(df, read.xlsx2("weather.xlsx",sheetIndex = x))

cities<-df$Station.Name
time<-df$Period
month<-df$Month
values<-as.numeric(df$Mean.Rainfall.in)
data_cube <- with(df, tapply(values, list(cities, time,month), mean))
rain_cube=tapply(as.numeric(as.character(df$Mean.Rainfall.in)),df[,c("Station.Name","Period","Month")],FUN=function(x){return(mean(x))})
#using slice
cat("Taking a slice to obtain the data of Agartala for the period 1953-2000 for all 12 months","\n")
rain_cube["Agartala (A)","1953-2000",]

#using dice
cat("Dicing to obtain the rainfall data of Agartala for July and August","\n")
cat("rainfall",rain_cube["Agartala (A)","1953-2000",c("July","August")],"\n")

#using rollup
cat("Mean rainfall data of Ajmer for all the twelve months for the period 1901-2000","\n")

cat(apply(rain_cube, c("Station.Name","Period"),
          FUN=function(x) {return(mean(x, na.rm=TRUE))})["Ajmer","1901-2000"],"\n")



#using drill down
cat("Drilling down to obtain the  mean rainfall data of the city of Ajmer for all 12 months for all valid periods","\n")

cat(apply(rain_cube, c("Station.Name"),FUN=function(x) {return(mean(x, na.rm=TRUE))})["Ajmer"],"\n")

maximum_cube=tapply(as.numeric(as.character(df$Mean.Temperature.oC)),df[,c("Station.Name","Period","Month")],FUN=function(x){return(mean(x))})
#using slice
cat("Taking a slice to obtain the Max temp data of Agartala for the period 1953-2000 for all 12 months","\n")
maximum_cube["Agartala (A)","1953-2000",]

#using dice
cat("Dicing to obtain the Max temp data of Agartala for July and August","\n")
maximum_cube["Agartala (A)","1953-2000",c("July","August")]

#using rollup
cat("Mean max temp data of Ajmer for all the twelve months for the period 1901-2000","\n")

cat(apply(maximum_cube, c("Station.Name","Period"),
          FUN=function(x) {return(mean(x, na.rm=TRUE))})["Ajmer","1901-2000"],"\n")



#using drill down
cat("Drilling down to obtain the  mean maxtemp data of the city of Ajmer for all 12 months for all valid periods","\n")

cat(apply(maximum_cube, c("Station.Name"),FUN=function(x) {return(mean(x, na.rm=TRUE))})["Ajmer"],"\n")
