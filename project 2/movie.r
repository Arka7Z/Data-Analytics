options(java.parameters = "- Xmx1024m")
sourceDir <- getSrcDirectory(function(dummies) {dummies})
setwd(sourceDir)
if((any(grepl("matrixStats",installed.packages())))==FALSE)
  install.packages("matrixStats")
if((any(grepl("xlsx",installed.packages())))==FALSE)
  install.packages("xlsx")
library(rJava)
library(xlsxjars)
library(xlsx)
library(matrixStats)


data<-read.xlsx("MOVIE.xlsx",sheetIndex=1)
data<-data[complete.cases(data),]

dataupto15<-data[as.numeric(as.character( data$Column.25))<=2015,]
imdbScoresupto15<-as.numeric(as.character(dataupto15$Column.27))
imbdbScoresupto15<-imdbScoresupto15[complete.cases(imdbScoresupto15)]
imdbMeanScoresUpto15<-mean(imdbScoresupto15,na.rm = TRUE)
cat("Mean IMDb score of movies upto 2015 is",imdbMeanScoresUpto15,"\n")

sampleScores<-data[as.numeric(as.character( data$Column.25))==2016,]
sampleScores<-as.numeric(as.character(sampleScores$Column.27))
sampleScores<-sampleScores[complete.cases(sampleScores)]     # Sample of IMDb scores of movies in 2016 

                                      # Size of the sample
n<-length(sampleScores)

populationMean<-mean(imdbMeanScoresUpto15,na.rm=TRUE)                         # Calculating population mean
sampleMean<-mean(sampleScores,na.rm = TRUE)                 # Calculaitng sample mean
sigma<-colSds(as.matrix(imdbScoresupto15), na.rm=TRUE) 
s<-sqrt(var(sampleScores, na.rm=TRUE) )

n1<-(populationMean-sampleMean)/(sigma/sqrt(n))             # Assuming normal distribution
t<-(populationMean-sampleMean)/(s/sqrt(n))                 # Assuming T-distribution
  
p1=pnorm(n1, mean=0, sd=1, lower.tail=TRUE)                # P value assuming standard normal distribution
cat(p1,"\n")                                              # Reject hypothesis if  p  <0.05 or p> 0.95
p2=pt(t,n-1)                                              # P value assumingstandard t distribution
cat(p2,"\n")                                              # Reject hypothesis if p value <0.05 or > 0.95
