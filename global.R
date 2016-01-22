library(shiny)
library(maptools)
library(scales)
library(ape)

# get data
fullmat<- read.delim("data/maizteocintle_SNP50k_meta_extended_4shiny.txt", sep="\t", header=TRUE)
maizemat<-fullmat[1:161,] # keep only maize
teosmat<-fullmat[162:166,]

mapregio<-readShapePoly("data/destdv250k_2gw/destdv250k_2gw.shp")

maizetree<- read.nexus("data/tree")

# order by landraces group
x<-fullmat[!duplicated(fullmat$Raza),] 
x<-x[, c(4,18)]
x<-x[order(x$Sanchezetal_grupo),]
x$Raza<-factor(as.vector(x$Raza), levels=as.vector(x$Raza))

