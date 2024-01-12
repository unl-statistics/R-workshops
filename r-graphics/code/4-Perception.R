## ----setup, include=FALSE-----------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)


## ----setup2-------------------------------------------------------------------
library(ggplot2)
library(ggsci)
library(ggthemes)
library(gridExtra)
library(grid)
library(dplyr)

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



## ----rand, fig.height=7, fig.width=6, fig.position="center"-------------------
library(tidyverse)
library(spatstat)

#  matern model
pp <- rMaternI(300, .02, stationary=FALSE)
dat <- tibble(x = pp$x, y = pp$y)
a1 <- ggplot(dat) + geom_point(aes(x = x, y =y )) + theme_void() + labs(x="", y="", title="Matern Model")


# uniform Poisson process with intensity 150 in the unit square
pp2 <- rpoispp(200)
dat2 <- tibble(x = pp2$x, y = pp2$y)
a2 <- ggplot(dat2) + geom_point(aes(x = x, y =y )) + theme_void() + labs(x="", y="", title="Poisson Process")

grid.arrange(a2, a1, ncol = 1, nrow = 2)


## ----gestalt-hierarchy--------------------------------------------------------
tibble("Gestalt Hierarchy" = c("Enclosure", "Connection", "Proximitiy", "Similarity"),
       "Graphs" = c("Facets", "Lines", "White Space", "Color/Shape")) %>% knitr::kable()


## ----gestalt-swimming-data, eval = T, echo = T--------------------------------
swimming <- read.csv("https://raw.githubusercontent.com/unl-statistics/R-workshops/main/r-graphics/data/gestalt-swimming.csv")


## ----gestalt-swimming2, echo = F----------------------------------------------
factorCols <- c("Location", "WaterTemp", "Time")
swimming[,factorCols] <- lapply(swimming[,factorCols], factor)
swimming$Time <- relevel(swimming$Time, ref = "pre")
summary(swimming)


## ----echo = F, eval = F-------------------------------------------------------
## ggplot(data = swimming, aes(x = Time, y = AvgTemp)) +
##   geom_bar(stat = "identity", position = "dodge", aes(fill = WaterTemp), color = "black") +
##   facet_grid(~Location)


## ----swimming-plots1, fig.height = 3, fig.width = 12, fig.align = "center"----
ggplot(data = swimming, aes(x = Time, y = AvgTemp)) +
  geom_bar(stat = "identity", position = "dodge", aes(fill = WaterTemp), color = "black") +
  facet_grid(~Location) +
  theme(aspect.ratio = 0.75,
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        strip.text = element_text(size = 14))


## ----echo = F, eval = F-------------------------------------------------------
## ggplot(data = swimming, aes(x = WaterTemp, y = AvgTemp)) +
##   geom_bar(stat = "identity", position = "dodge", aes(fill = Time), color = "black") +
##   facet_grid(~Location) +
##   scale_fill_brewer()


## ----swimming-plots2, fig.height = 3, fig.width = 12, fig.align = "center"----
ggplot(data = swimming, aes(x = WaterTemp, y = AvgTemp)) +
  geom_bar(stat = "identity", position = "dodge", aes(fill = Time), color = "black") +
  facet_grid(~Location) +
  theme(aspect.ratio = 0.75,
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        strip.text = element_text(size = 14)) +
  scale_fill_brewer()


## ----swimming-plots3, fig.height = 2.5, fig.width = 12, fig.align = "center"----
ggplot(data = swimming, aes(x = Time, y = AvgTemp)) +
  geom_point(aes(color = WaterTemp)) +
  facet_grid(~Location) +
  theme(aspect.ratio = 0.75,
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        strip.text = element_text(size = 14))


## ----swimming-plots4, fig.height = 2.5, fig.width = 12, fig.align = "center"----
ggplot(data = swimming, aes(x = Time, y = AvgTemp, color = WaterTemp)) +
  geom_point() +
  geom_line(aes(group = WaterTemp)) +
  facet_grid(~Location) +
  theme(aspect.ratio = 0.75,
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        strip.text = element_text(size = 14))


## ----fig.align="center"-------------------------------------------------------
library(RColorBrewer)
library(tidyverse)

data <- data.frame(expand.grid(x = 1:6, y = 1:6), color = factor(sample(c(1, 2), 36, replace = TRUE)))
data$x <- data$x + rnorm(36, 0, .25)
data$y <- data$y + rnorm(36, 0, .25)
data$shape <- factor(c(rep(2, 15), 1, rep(2,20)))

ggplot(data, aes(x, y)) + geom_point(aes(shape = shape), size = 5, colour = "#1B9E77") + theme_void() + theme(legend.position = "none")


## ----fig.align="center"-------------------------------------------------------
data$shape <- factor(c(rep(2, 25), 1, rep(2, 10)))

ggplot(data, aes(x, y)) + geom_point(aes(colour = shape), size = 5, shape = I(19)) + theme_void() + theme(legend.position = "none") + scale_colour_brewer(palette="Dark2")


## ----fig.align="center"-------------------------------------------------------
data$shape <- data$color

ggplot(data, aes(x, y)) + geom_point(aes(colour = color, shape = shape), size = 5) + theme_void() + theme(legend.position = "none") + scale_colour_brewer(palette="Dark2")


## ----fig.align="center"-------------------------------------------------------

data$shape[1] <- if(data$shape[1]==2) 1 else 2

ggplot(data, aes(x, y)) + geom_point(aes(colour = shape), shape = 19, size = 5) + theme_void() + theme(legend.position = "none") + scale_colour_brewer(palette="Dark2")




## ----echo=FALSE, fig.width=20-------------------------------------------------
library(RColorBrewer)
library(gridExtra)

data <- data.frame(x = c(1, 2, 3, 4, 5), 
                   y = c(1, 4, 9, 10, 12), 
                   size = c(1, 4, 2, 1, 5))

p1 <- qplot(x, y, data = data, size = size, geom = "point") + 
    scale_size_continuous(range = c(2.5, 5), guide = "none") + 
    theme_bw()  + 
    theme(axis.text = element_blank())

data <- data.frame(x = factor(c(1, 2, 3, 4, 5)), 
                   y = c(4, 3, 1, 5, 2))

p2 <- ggplot(data = data, aes(x = x, weight = y)) + 
    geom_bar() + 
    theme_bw() + 
    theme(axis.text = element_blank())

data <- data.frame(expand.grid(x = 1:6, y = 1:2), 
                   color = c(brewer.pal(7, "Blues")[2:7], 
                             brewer.pal(6, "Set1")))

p3 <- ggplot(data = data, aes(x = x, y = factor(y), color = color)) + 
    geom_point(size = 5) + 
    scale_color_identity() + 
    ylab("") + 
    xlab("") + 
    theme_bw() + 
    theme(axis.text = element_blank())

grid.arrange(p1, p2, p3, nrow = 1)


## ----echo=FALSE, fig.width=7, fig.height=1.2----------------------------------
data <- data.frame(x = 1:7, 
                   blues = brewer.pal(7, "Blues"), 
                   set1 = brewer.pal(7, "Set1"), 
                   diverge = brewer.pal(7,"RdBu"))

qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = set1) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    theme_void()


## ----echo=FALSE, fig.width=10, fig.height=1.2---------------------------------

getPalette = colorRampPalette(brewer.pal(9, "Set1"))

data2 <- data.frame(x = 1:20, 
                   expanded = getPalette(20))

qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data2, geom = "rect", color = I("black"), fill = expanded) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    theme_void()


## ----echo=FALSE, fig.width=7, fig.height=1.2----------------------------------
qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = blues) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    theme_void()


## ----echo=FALSE, fig.width=7, fig.height=1.5----------------------------------
qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = diverge) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    theme_void()


## ----fig.align='top', fig.height=4, fig.width=10------------------------------
p1 <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + geom_point() + scale_color_locuszoom() +labs(x = "city mpg", y = "highway mpg", title = "Factor variable")
p2 <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = hwy)) + geom_point() + labs(x = "city mpg", y = "highway mpg", title = "Continuous variable")
grid.arrange(p1, p2, ncol = 2, nrow = 1)


## ----echo=FALSE, fig.height=6, fig.width=12-----------------------------------
library(ggsci)
library(viridis)
library(wesanderson)
library(RColorBrewer)

p1 = ggplot(data = mpg, aes(x = class, fill = class)) + geom_bar() +
  theme_bw() +theme(legend.position = "none")
p11<- p1 +labs(title= "ggplot2 default")
p2 = p1 + scale_fill_npg() + labs(title = "NPG")
p3 = p1 + scale_fill_startrek() + labs(title = "Star Trek")
p4 = p1 + scale_fill_ucscgb() + labs(title = "UCSCGB")
p5 = p1 + scale_fill_viridis(discrete = TRUE) + labs(title = "Viridis")
p6 = p1 + scale_fill_viridis(option="magma", discrete = TRUE) + labs(title = "Magma")
#p7 = p1 + scale_color_manual(values = wes_palette(4, "Rushmore")) + labs(title = "Rushmore")
#p8 = p1 + scale_color_manual(values = wes_palette(5, "Zissou")) + labs(title = "Zissou")
p9 = p1 + scale_fill_brewer(palette="Set2") + labs(title = "Set2")
p0 = p1 + scale_fill_brewer(palette="Dark2") + labs(title = "Dark2")

grid.arrange(p11, p2, p3, p4, p5, p6, #p7, p8, 
             p9, p0, nrow = 2)



## ----diamonds-data, echo = T, eval = F----------------------------------------
## data(diamonds)


## ----echo = TRUE--------------------------------------------------------------
movies <- read.csv("https://raw.githubusercontent.com/unl-statistics/R-workshops/main/r-graphics/data/MovieSummary.csv")

