## ----setup, include=FALSE-----------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)


## -----------------------------------------------------------------------------
library(ggplot2)
library(ggsci)
library(ggthemes)
library(gridExtra)
library(grid)
library(dplyr)
library(tidyr)

grid_arrange_shared_legend <- function(..., ncol = length(list(...)), nrow = 1, position = c("bottom", "right")) {

  plots <- list(...)
  position <- match.arg(position)
  g <- ggplotGrob(plots[[1]] + theme(legend.position = position))$grobs
  legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
  lheight <- sum(legend$height)
  lwidth <- sum(legend$width)
  gl <- lapply(plots, function(x) x + theme(legend.position="none"))
  gl <- c(gl, ncol = ncol, nrow = nrow)

  combined <- switch(position,
                     "bottom" = arrangeGrob(do.call(arrangeGrob, gl),
                                            legend,
                                            ncol = 1,
                                            heights = unit.c(unit(1, "npc") - lheight, lheight)),
                     "right" = arrangeGrob(do.call(arrangeGrob, gl),
                                           legend,
                                           ncol = 2,
                                           widths = unit.c(unit(1, "npc") - lwidth, lwidth)))
  
  grid.newpage()
  grid.draw(combined)

  # return gtable invisibly
  invisible(combined)

}



## ----anscombe-set1------------------------------------------------------------
quartet_setI <- anscombe %>%
  select(x1, y1) %>%
  mutate(set = "I") %>%
  rename(x = x1, 
         y = y1)
quartet_setI %>% select(x, y) %>% knitr::kable(caption = "Set I")


## ----anscombe-set2------------------------------------------------------------
quartet_setII <- anscombe %>%
  select(x2, y2) %>%
  mutate(set = "II") %>%
  rename(x = x2, 
         y = y2)
quartet_setII %>% select(x, y) %>% knitr::kable(caption = "Set II")


## ----anscombe-set3------------------------------------------------------------
quartet_setIII <- anscombe %>%
  select(x3, y3) %>%
  mutate(set = "III") %>%
  rename(x = x3, 
         y = y3)
quartet_setIII %>% select(x, y) %>% knitr::kable(caption = "Set III")


## ----anscombe-set4------------------------------------------------------------
quartet_setIV <- anscombe %>%
  select(x4, y4) %>%
  mutate(set = "IV") %>%
  rename(x = x4, 
         y = y4)
quartet_setIV %>% select(x, y) %>% knitr::kable(caption = "Set IV")


## ----quartet-summary----------------------------------------------------------
quartet <- rbind(quartet_setI,
                 quartet_setII,
                 quartet_setIII,
                 quartet_setIV) %>%
  select(set, x, y)

quartet_summary <- quartet %>%
  group_by(set) %>%
  summarize("mean(x)"  = round(mean(x),2), 
            "sd(x)"    = round(sd(x),2), 
            "mean(y)"  = round(mean(y),2), 
            "sd(y)"    = round(sd(y),2), 
            "cor(x,y)" = round(cor(x,y),2)) %>% 
  t()

colnames(quartet_summary) <- quartet_summary[1,]
quartet_summary <- quartet_summary[-1,] %>%
  as.data.frame()

quartet_summary %>%
  knitr::kable(digits = 2)


## ----, quartet-plots, fig.height = 7, fig.width = 7, fig.align = "center"-----
ggplot(quartet, aes(x, y)) + 
  geom_point(colour = "green4", size = 2.5) + 
  geom_smooth(method = lm, se = FALSE, colour = "gray", alpha = .5) +
  facet_wrap(~ set) +
  theme_bw() +
  theme(aspect.ratio = 1,
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 16),
        strip.text = element_text(size = 16))


## ----eval = FALSE-------------------------------------------------------------
## preg <- read.csv("data/preg.csv", stringsAsFactors = FALSE)
## preg
## knitr::kable(preg, format = 'html')
## preg2 <- read.csv("data/preg2.csv", stringsAsFactors = FALSE)
## preg2
## knitr::kable(preg2, format = 'html')
## 
## preg3 <- preg %>% gather(treatment, measurement, -name)
## preg3
## 


## ----fig.width=3, fig.height=3.7,echo=FALSE, fig.align="center"---------------
library(png)
library(grid)
img <- readPNG("images/tablelong2.png")
 grid.raster(img)


## ----eval=FALSE, echo=TRUE----------------------------------------------------
## data(french_fries, package = "reshape2")
## head(french_fries)


## ----eval=T, echo=F-----------------------------------------------------------
library(reshape2)
data(french_fries)
head(french_fries)%>% knitr::kable(row.names = F)


## ----eval=FALSE, echo=TRUE----------------------------------------------------
## french_fries_long <- french_fries %>%
##   pivot_longer(cols = c("potato":"painty"), #<<
##                names_to = "variable", #<<
##                values_to = "value") #<<
## head(french_fries_long)


## ----eval=T, echo=F-----------------------------------------------------------
french_fries_long <- french_fries %>% 
  pivot_longer(cols = c("potato":"painty"),
               names_to = "variable",
               values_to = "value")
head(french_fries_long) %>% knitr::kable(row.names = F)


## ----preg, echo = T, eval = T-------------------------------------------------
preg <- tibble(pregnant = c("yes", "no"),
               male = c(NA, 10),
               female = c(20, 12))
preg

