## ---- echo = FALSE--------------------------------------------------------------------------------------
knitr::include_graphics("knitr.png")


## ---- echo=FALSE, out.height="40%", out.width="60%"-----------------------------------------------------
knitr::include_graphics("markdown.png")


## ----plot_example, fig.height=4.5-----------------------------------------------------------------------
set.seed(1121)
x=rnorm(20)

boxplot(x)



## ---- eval=FALSE----------------------------------------------------------------------------------------
## x <- rnorm(50)
## 
## library(ggplot2)
## qplot(x, geom = "histogram")


## -------------------------------------------------------------------------------------------------------

knitr::kable(head(iris), "pipe")



## ---- echo = TRUE, out.height="50%", out.width="50%"----------------------------------------------------
knitr::include_graphics("IncludeGraphic.png")

