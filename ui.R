source("global.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        title="Explorador de la variación genética de las razas de maíz mexicanas",
            div(img(src="conabio.png"), style="text-align: center;"),
            h1("Explorador de la variación genética de las razas de maíz mexicanas",align = "center"),
        
            p("Abajo se muestran un análisis de componentes principales y un árbol de distancias",
              "realizados con 36,931 SNPs genotipificados con el chip Illumina MaizeSNP50 en 161 accesiones del", 
              tags$a(href="http://www.biodiversidad.gob.mx/genes/proyectoMaices.html", "Proyecto Global de Maíces Nativos.")),
            
            p("Los detalles metodológicos del muestreo y análisis bioinformáticos se encuentran publicados (acceso libre) en:",
              "Artega", em("et al."), "(2015) Genomic variation in recently collected maize landraces from Mexico,", 
              em("Genomics Data,"), "7: 38–45. http://dx.doi.org/10.1016/j.gdata.2015.11.002. Por favor cita dicho trabajo y el link a esta página si utilizas esta app.",
              "Los datos pueden decargarse en este",  tags$a(href="http://datadryad.org/resource/doi:10.5061/dryad.4t20n", "repositorio.")),
            
            p("Puedes explorar la distribución de la variación genética según las características",
              "biológicas y físicas de las muestras que se muestran en el panel de opciones de la izquierda."),
  
            p("Para obtener más información sobre cada raza, visita nuestra", 
              tags$a(href="http://www.biodiversidad.gob.mx/usos/maices/razas2012.html", "página de las razas de maíz de México.")),
      
            p("Las muestras de semillas de maíz utilizadasfueron proporcionadas por el Banco de Germoplasma de la región Centro del INIFAP.", 
              "El proyecto fue financiado por la Dirección General del Sector Primario y Recursos Naturales Renovables (DGSPRNR) de la SEMARNAT"),
  
            p("Dudas y reporte de errores dirigirlos a Alicia Mastretta-Yanes a amastretta@conabio.gob.mx"),
            
       fluidRow(
        column(2,
               h3("Opciones", align = "center"),
               # Color by
               selectInput(inputId= "ColorBy", label="Colorear por:", 
                           choices= c("Raza", "Longitud", "Latitud", 
                                      "Altitud" , "Categoría de altitud" , 
                                      "Grupo ecológico", "Grupo Morfológico",  
                                      "Biogeografía de México", "División Florística" , 
                                      "Biogeografía del maíz" )),
               
               # Restrict to
               sliderInput(inputId= "Altitud", label="Restringir a altitud:", min=0, max=3000, value=c(0,3000)),
               
               sliderInput(inputId= "Latitud", label="Restringir a latitud:", 
                           min=round(min(fullmat$Latitud), 2), max=round(max(fullmat$Latitud),2),
                           round=TRUE,  step=0.1,
                           value=c(min(fullmat$Latitud), max(fullmat$Latitud))),
               
               sliderInput(inputId= "Longitud", label="Restringir a longitud:", 
                           min=round(min(fullmat$Longitud), 2), max=round(max(fullmat$Longitud),2),
                           round=TRUE,  step=0.1,
                           value=c(min(fullmat$Longitud), max(fullmat$Longitud))),
               
               
               # Select landraces / estado
               
               
               checkboxGroupInput(inputId="Razas", 
                                  label="Mostrar las razas:", 
                                  choices=levels(x$Raza)[1:46], selected=levels(x$Raza)[1:46]), # x is fullmat$Ra
               
               checkboxGroupInput(inputId="Estados", 
                                  label="Mostrar muestras de los Estados:", 
                                  choices=levels(fullmat$Estado), selected=levels(fullmat$Estado))              
               
               ),
        
        column(7,
               h3("Gráficas", align = "center"),
               # Plot PCA
               h4("Análisis de componentes principales", align = "center"),
               plotOutput(outputId="pca", width = "100%", height = "400px"), 
               
               # Plot tree
               h4("Árbol de distancia genéticas", align = "center"),
               plotOutput(outputId="tree", width = "100%", height = "400px"),
               
               # Plot map
               h4("Distribución geográfica", align = "center"),
               plotOutput(outputId="mapa", width = "100%", height = "400px")
               
               ),
        
        column(3, 
               h3("Leyenda", align = "center"),
               imageOutput(outputId="Legend")
               )
        
       )
        
  )
)




