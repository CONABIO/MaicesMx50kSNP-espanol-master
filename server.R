# Define server logic required to draw plots
shinyServer(function(input, output) {
  

  ## Subset   
  maizemat2<- reactive({
    # by desired Altitude
    maizemat<-maizemat[c(maizemat$Altitud>=input$Altitud[1] & maizemat$Altitud<=input$Altitud[2]),]
    
    # by desired Longitude
    maizemat<-maizemat[c(maizemat$Longitud>=input$Longitud[1] & maizemat$Longitud<=input$Longitud[2]),]
    
    # by desired Latitud
    maizemat<-maizemat[c(maizemat$Latitud>=input$Latitud[1] & maizemat$Latitud<=input$Latitud[2]),]
    
    # by desired landraces
    maizemat<-maizemat[maizemat$Raza %in% input$Razas, ]
    
    # by desired Estados
    maizemat<-maizemat[maizemat$Estado %in% input$Estados, ]
      })
  
  
    ## Plots
    # Plot PCA
    output$pca<- renderPlot({
      
      # Define colors
      if(input$ColorBy=="Raza") ColorBy <-maizemat2()$ColorByRaza
      if(input$ColorBy=="Longitud") ColorBy <-maizemat2()$ColorByLong
      if(input$ColorBy=="Latitud") ColorBy <-maizemat2()$ColorByLat
      if(input$ColorBy=="Altitud") ColorBy <-maizemat2()$ColorByAlt
      if(input$ColorBy=="Grupo ecológico") ColorBy <-maizemat2()$ColorByGpEc
      if(input$ColorBy=="Grupo Morfológico") ColorBy <-maizemat2()$ColorByTax
      if(input$ColorBy=="Categoría de altitud") ColorBy <-maizemat2()$ColorByCategAlt
      if(input$ColorBy=="Biogeografía de México") ColorBy <-maizemat2()$ColorByBiogeo
      if(input$ColorBy=="División Florística") ColorBy <-maizemat2()$ColorByDivFloristic
      if(input$ColorBy=="Biogeografía del maíz") ColorBy <-maizemat2()$ColorByPeralesBiog
      
      # Plot
      plot(maizemat2()$pca.eigenvect...2., maizemat2()$pca.eigenvect...1.,  pch=19,              
           xlab= paste0("eigenvector 2 explaining ", "2.13 %"), # this adds the % of variation that is accounted for by eigenvector 2 to the axis label
           ylab= paste0("eigenvector 1 explaining ", "6.44 %"),
           col=alpha(ColorBy, 0.6))
                    })
    
    # Plot Tree
    
    output$tree<- renderPlot({
      
      # Define ColorBy and palette
      if(input$ColorBy=="Raza") {
        ColorBy <-maizemat2()$Raza
        numcolsneeded<-length(levels(fullmat$Raza))-2
        palette(rainbow(numcolsneeded))
        fullmat$Raza<-factor(as.vector(fullmat$Raza), levels=as.vector(x$Raza))
      }
      
      if(input$ColorBy=="Longitud") { 
        ColorBy <-as.factor(maizemat2()$Longitud)
        numcolsneeded<-length(levels(as.factor(fullmat$Longitud)))
        palette(cm.colors(numcolsneeded))
      }
      
      if(input$ColorBy=="Latitud") {
        ColorBy <-as.factor(maizemat2()$Latitud)
        numcolsneeded<-length(levels(as.factor(fullmat$Latitud)))
        palette(cm.colors(numcolsneeded))
      }
      
      if(input$ColorBy=="Altitud") {
        ColorBy <-maizemat2()$Altitud
        numcolsneeded<-length(levels(as.factor(fullmat$Altitud)))
        palette(rev(terrain.colors(numcolsneeded)))
      }
      
      if(input$ColorBy=="Grupo ecológico") {
        ColorBy <-maizemat2()$Ruizetal2008_grupo
        palette(c("white", "turquoise", "lightseagreen", "mediumturquoise", "gold", "goldenrod", "darkgoldenrod", "khaki", "yellow3", "yellow", "red", "darkred", "grey"))
      }
      
      if(input$ColorBy=="Grupo Morfológico"){ 
        ColorBy <-maizemat2()$Sanchezetal_grupo
        palette(c("orangered3", "yellow2", "springgreen4", "cyan", "mediumblue", "violetred", "red2", "black", "black"))
      }  
        
      if(input$ColorBy=="Categoría de altitud") {
        ColorBy <-maizemat2()$Categ.Altitud
        numcolsneeded<-length(levels(fullmat$Categ.Altitud))
        palette(rainbow(numcolsneeded))
      }
      
      if(input$ColorBy=="Biogeografía de México") {
        ColorBy <-maizemat2()$Rbiogeo
        palette(c("#FF0000FF", "#FF9900FF", "#CCFF00FF", "#00FF66FF", "#0066FFFF", "#3300FFFF", "#CC00FFFF", "#FF0099FF", "#865700",   "#007700",   "#007F57",   "#007D99", "#0068C5",   "#8330CB",   "#B700A2"))
      }
      
      if(input$ColorBy=="División Florística") {
        ColorBy <-maizemat2()$DivFloristic
        palette(c("#FF0000FF", "#FFFF00FF", "#00FFFFFF", "#0000FFFF", "#FF00FFFF", "#865700", "#007D99", "green3", "#B8095F", "gold",  "blue4",  "magenta3", "#4F6A00"))
      }
      
      if(input$ColorBy=="Biogeografía del maíz") {
        ColorBy <-maizemat2()$PeralesBiog
        palette(c("red", "darkorange2", "#00FFFFFF", "#0000FFFF", "#FF00FFFF",   "blue4", "green3",  "#865700", "#B8095F", "gold"))
      }
      
       # Plot
          
      # define tips
        tipmaiz<-match(maizemat2()$NSiembra, maizemat$NSiembra)
        tipmaiz<-tipmaiz[!c(tipmaiz %in% c(162:165))]
        
        tippar<-match(maizemat2()$NSiembra, maizemat$NSiembra)
        tippar<-tippar[c(tippar %in% c(162:163))]
      
        tipmex<-match(maizemat2()$NSiembra, maizemat$NSiembra)
        tipmex<-tipmex[c(tipmex %in% c(164:165))]
        
        # plot 
      plot(maizetree, type="unrooted", show.tip=FALSE, edge.width=0.1)
        tiplabels(tip=tipmaiz, pch=20, col=ColorBy)
        tiplabels(tip=c(162:165), pch=c(15,17), col="black")

    })
     
    # Distribution map
  
  
     output$mapa<- renderPlot({
        
       # Define colors
       if(input$ColorBy=="Raza") ColorBy <-maizemat2()$ColorByRaza
       if(input$ColorBy=="Longitud") ColorBy <-maizemat2()$ColorByLong
       if(input$ColorBy=="Latitud") ColorBy <-maizemat2()$ColorByLat
       if(input$ColorBy=="Altitud") ColorBy <-maizemat2()$ColorByAlt
       if(input$ColorBy=="Grupo ecológico") ColorBy <-maizemat2()$ColorByGpEc
       if(input$ColorBy=="Grupo Morfológico") ColorBy <-maizemat2()$ColorByTax
       if(input$ColorBy=="Categoría de altitud") ColorBy <-maizemat2()$ColorByCategAlt
       if(input$ColorBy=="Biogeografía de México") ColorBy <-maizemat2()$ColorByBiogeo
       if(input$ColorBy=="División Florística") ColorBy <-maizemat2()$ColorByDivFloristic
       if(input$ColorBy=="Biogeografía del maíz") ColorBy <-maizemat2()$ColorByPeralesBiog
       
      # Plot
      plot(mapregio, border="grey", lwd=0.8)
      points(x=maizemat2()$Longitud, y= maizemat2()$Latitud, pch=19, cex=0.8, col=alpha(ColorBy, 0.6))                
                       })
     
     output$Legend<- renderImage({
       
       # Define colors
       if(input$ColorBy=="Raza") Leg <-"www/landracesSpa.png"
       if(input$ColorBy=="Longitud") Leg <-"www/LonglegendSpa.png"
       if(input$ColorBy=="Latitud") Leg <- "www/latlegendSpa.png"
       if(input$ColorBy=="Altitud") Leg <- "www/AltSpa.png"
       if(input$ColorBy=="Grupo ecológico") Leg <- "www/EcolgrpSpa.png"
       if(input$ColorBy=="Grupo Morfológico") Leg <- "www/groupsSpa.png"
       if(input$ColorBy=="Categoría de altitud") Leg <- "www/catAltSpa.png"
       if(input$ColorBy=="Biogeografía de México") Leg <- ""
       if(input$ColorBy=="División Florística") Leg <- ""
       if(input$ColorBy=="Biogeografía del maíz") Leg <- "www/BiogeoSpa.png"
       
       
         list(src=Leg)
            }, deleteFile = FALSE)     
     
     
  
})

