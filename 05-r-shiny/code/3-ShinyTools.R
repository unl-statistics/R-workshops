## ---- eval = FALSE-------------------------------------
## server  <-  function(input, output) {
##   # make output objects from inputs
## 
##   `output$hist` <- `renderPlot`({
##     # code for plot
## 
##   })
## }


## ---- eval = FALSE-------------------------------------
## server <- function(input, output) {
##     output$hist <- renderPlot(`{`
## 
##         dist <- rnorm(n = `input$num`)
## 
##         gg <- data.frame(dist) %>%
##           ggplot(aes(x = dist)) +
##             geom_histogram(binwidth = 0.25) +
##             xlim(c(-10,10))
## 
##         print(gg)
##     `}`)
## }


## ---- eval = F-----------------------------------------
## reactiveValue <- `reactive`({
##     # stuff goes here
##   })
## 
## output$xxx <- renderXXX({
##   value <- `reactiveValue()`
##   # stuff goes here
## })


## ---- eval=FALSE---------------------------------------
## runApp("02_Reactivity", display.mode = "showcase")


## ---- eval=FALSE---------------------------------------
## runApp("03_NYC_Emergency")

