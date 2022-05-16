## ---- eval=FALSE--------------------------------------------------------------------------------------------------
## library(shiny)
## 
## # A simple/common user interface template
## ui <- fluidPage(
## 
##   # Application title
##   titlePanel("Title"),
## 
##   sidebarPanel(
##     # Define some inputs here
##   ),
## 
##   mainPanel(
##     # outputs` (from the server) go here
##   )
## 
## )


## ---- eval=FALSE--------------------------------------------------------------------------------------------------
## # Server side logic
## server <- function(input, output) {
##   # do something
## }


## ---- minimal-shiny, echo = T, eval = F---------------------------------------------------------------------------
## library(shiny)
## 
## ui <- fluidPage(
##   "My simple shiny app!"
## )
## 
## server <- function(input, output, session) {
## }
## 
## shinyApp(ui, server)


## ----eval = FALSE-------------------------------------------------------------------------------------------------
## textInput("text", # ID R uses to recognize this input
##           label = h3("Text input"), # human-readable label
##           value = "Enter text...") # starting input


## ----eval = FALSE-------------------------------------------------------------------------------------------------
## h3("Hello")


## ----eval = FALSE-------------------------------------------------------------------------------------------------
## selectInput("select",
##             label = h3("What do you like?"),
##             choices = c("Pizza", "Ice cream", "Donuts", "None of the above"),
##             selected = 2)


## ---- eval=FALSE--------------------------------------------------------------------------------------------------
## runApp("01_Hello", display.mode = "showcase")

