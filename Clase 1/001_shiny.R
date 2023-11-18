install.packages(
  c("tidyverse", "shiny", "shinythemes", "shinyWidgets",
    "shinydashboard", "DT", "leaflet", "plotly", "highcharter")
)
library(shiny)
ui <- fluidPage()
server <- function(input, output) {}
runApp(list(ui = ui, server = server))