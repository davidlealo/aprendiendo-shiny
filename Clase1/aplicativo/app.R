library(shiny)

ui <- fluidPage(

    
    titlePanel("Aplicación - Calculadora"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("num1",
                        "Número 1:",
                        min = 1,
                        max = 50,
                        value = 30),
            numericInput("num2", "Número 2", value=0)
        ),

        mainPanel(
           textOutput("salida1"),
           textOutput("salida2"),
           textOutput("salida3")
        )
    )
)

server <- function(input, output) {

    output$salida1 <- renderText({
      x <- input$num1
      x
    })
    output$salida2 <- renderText({
      input$num2
    })
    
    output$salida3 <- renderText({
      input$num1 + as.numeric(input$num2)
    })
}

shinyApp(ui = ui, server = server)
