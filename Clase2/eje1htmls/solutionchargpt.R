library(shiny)
library(leaflet)
library(rvest)
library(tidyverse)
library(glue)
library(lubridate)
library(janitor)

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
    fecha_seleccionada <- input$fecha
    message(fecha_seleccionada)
    
    url <- glue("https://www.sismologia.cl/sismicidad/catalogo/{year(fecha_seleccionada)}/{format(fecha_seleccionada, '%m')}/{format(fecha_seleccionada, '%Y%m%d')}.html")
    
    datos <- read_html(url) |>
      html_table() |>
      pluck(2) |>
      janitor::clean_names() |>
      separate(
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
