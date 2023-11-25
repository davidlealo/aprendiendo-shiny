library(shiny)


ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Number of observations:", min = 0, max = 1000, value = 500)
    ),
    mainPanel(
      tabsetPanel(
        id = "tab",
        tabPanel("Grafico", plotOutput("plot")),
        tabPanel("Dato"   , verbatimTextOutput("dato")),
        tabPanel("Tabla"  , tableOutput("tabla")),
        tabPanel("Lineas" , plotOutput("linea")),
        tabPanel("Summary", verbatimTextOutput("summary")),
      )
    )
  )
)

server <- function(input, output, session) {
  output$plot    <- renderPlot  ({ hist(rnorm(input$obs))})
  output$dato    <- renderText  ({ input$obs})
  output$tabla   <- renderTable ({ data.frame(input$obs) })
  
  output$linea   <- renderPlot  ({ plot(rnorm(input$obs), type = "l")})
  output$summary <- renderPrint ({ summary(rnorm(input$obs)) })
  
}

shinyApp(ui, server)
