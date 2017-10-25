options(java.parameters = "- Xmx1024m")
sourceDir <- getSrcDirectory(function(dummies) {dummies})
setwd(sourceDir)
if((any(grepl("xlsx",installed.packages())))==FALSE)
  install.packages("xlsx")
library(rJava)
library(xlsxjars)
library(xlsx)
data<-read.xlsx("MOVIE.xlsx",sheetIndex=1)
data<-data[complete.cases(data),]
dataupto15<-data[as.numeric(as.character( data$Column.25))<=2015,]
imdbScores<-as.numeric(as.character(dataupto15$Column.27))
imbdbScores<-imdbScores[complete.cases(imdbScores)]
imdbMeanScoreUpto15<-mean(imdbScores,na.rm = TRUE)
cat("Mean IMDb score of movies upto 2015 is",imdbMeanScoreUpto15,"\n")


moviesIn16<-dataupto15<-data[as.numeric(as.character( data$Column.25))==2016,]
