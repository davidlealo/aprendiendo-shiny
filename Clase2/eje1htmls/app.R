library(shiny)
library(leaflet)
library(rvest)
library(tidyverse)

ui <- fluidPage(

    titlePanel("Sismos por día"),

    sidebarLayout(
        sidebarPanel(
            dateInput("fecha", label = "Seleccionar fecha")
        ),

        mainPanel(
           leafletOutput("mapa")
        )
    )
)

server <- function(input, output) {

    output$mapa <- renderLeaflet({
      f <- input$fecha
      message(f)
      
      url <- str_glue("https://www.sismologia.cl/sismicidad/catalogo/{year(f)}/{format(f, '%m')}/{format(f, '%Y%m%d')}.html") 
      
      datos <- read_html(url) |>
        html_table() |>
        dplyr::nth(2) |>
        janitor::clean_names() |>
        tidyr::separate(
          latitud_longitud,
          into = c("latitud", "longitud"),
          sep = " ", convert = TRUE
        )
        
      leaflet(datos) %>%
        addTiles() %>%  
        addMarkers(
          lng = ~longitud, 
          lat = ~latitud,
          popup = ~as.character(magnitud_2)
        )
    })
}

shinyApp(ui = ui, server = server)
