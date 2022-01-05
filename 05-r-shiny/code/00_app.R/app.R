library(shiny)
ui <- fluidPage(
  "My simple shiny app!"
)
server <- function(input, output, session) {
}
shinyApp(ui, server)