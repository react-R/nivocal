library(shiny)
library(nivocal)

ui <- fluidPage(
  titlePanel("reactR HTMLWidget Example"),
  nivocalOutput('widgetOutput')
)

server <- function(input, output, session) {
  output$widgetOutput <- renderNivocal(
    nivocal("Hello world!")
  )
}

shinyApp(ui, server)