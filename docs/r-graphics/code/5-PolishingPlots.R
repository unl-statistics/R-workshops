## ----setup, include=FALSE-----------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = TRUE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)


## ----echo=FALSE---------------------------------------------------------------
library(ggplot2)
library(ggsci)
library(ggthemes)
library(gridExtra)
library(grid)

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



## ----echo=FALSE, fig.height=7, fig.width=10, message=FALSE, warning=FALSE-----
mtcars$gear <- factor(mtcars$gear)

p0 <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + geom_point() 

p11 <- p0 + 
  labs(title = "Default")

p2 <- p0 + 
  theme_classic() + 
  labs(title = "theme_classic")

p3 <- p0 + 
  theme_bw() + 
  labs(title = "theme_bw()")

p4 <- p0 +
  theme_dark() + 
  labs(title = "theme_dark")

p5 <- p0 + 
  theme_void() + 
  labs(title = "theme_void")

p6 <- p0 + 
  theme_minimal() + 
  labs(title = "theme_minimal")

grid.arrange(p11, p2, p3, p4, p5, p6, nrow = 2)


## ----echo=FALSE, fig.height=7, fig.width=10-----------------------------------
library(ggthemes)

# Economist theme
# A theme that approximates the style of plots in The Economist magazine.
p1 <- p0 + 
  theme_economist() + 
  scale_colour_economist() + 
  labs(title = "Economist")

p2 <- p0 + 
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_fivethirtyeight("cyl") +
  theme_fivethirtyeight() + labs(title = "FiveThirtyEight")

p3 <- p0 + 
  theme_igray() + 
  scale_colour_tableau()  + 
  labs(title = "Tableau")

p4 <- p0 + 
  geom_rangeframe() +
  theme_tufte() + 
  scale_x_continuous(breaks = extended_range_breaks()(mtcars$wt)) +
  scale_y_continuous(breaks = extended_range_breaks()(mtcars$mpg)) + 
  labs(title = "Tufte")

p5 <- p0 + 
  theme_wsj() + 
  scale_colour_wsj("colors6", "") + 
  labs(title = "Wall Street Journal")

p6 <- p0 + 
  ggtitle("Highcharts") +
  theme_hc() +
  scale_colour_hc()

p7 <- p0 +
  ggtitle("Highcharts dark") +
  theme_hc(style = "darkunica") +
  scale_fill_hc("darkunica")

p8 <- p0 + 
  theme_excel() + 
  scale_colour_excel() + 
  labs(title = "Excel 2003")

grid.arrange(p11, p1, p2, p3, p4, p5, p6, p7, p8, nrow = 3)


## ----fig.width=8, fig.height=5, fig.align = "center"--------------------------
theme_set(theme_bw()) #<<
ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + 
  geom_point()


## ----fig.height=4, fig.width=10, eval = FALSE---------------------------------
## p1 <- ggplot(mpg) +
##   geom_bar(aes(x = class, colour = manufacturer, fill = manufacturer) )
## 
## p2 <- p1 + #<<
##   theme_classic() +
##   ## modify plot background
##   theme(plot.background = element_rect(fill = "lightskyblue1",colour = "pink",size = 0.5, linetype = "longdash")) #<<


## ----fig.height=4.5, fig.width=12, echo = FALSE, fig.align = "center"---------
p1 <- ggplot(mpg) + 
  geom_bar(aes(x = class, colour = manufacturer, fill = manufacturer) ) 

p2 <- p1 + theme_classic() + theme(
  ## modify plot background
  plot.background = element_rect(fill = "lightskyblue1",colour = "pink",size = 0.5, linetype = "longdash")
  )
grid.arrange(p1, p2, nrow = 1)


## ----fig.height=4, fig.width=12, fig.align = "center"-------------------------
p3 <- p2 + 
  theme(
  ### move and modify legend 
  legend.title = element_blank(), #<<
  legend.position = "top", #<<
  legend.key = element_rect(fill = "lightskyblue1", color = "lightskyblue1"), #<<
  legend.background = element_rect( fill = "lightskyblue1",color = "pink", size = 0.5,linetype = "longdash") #<<
  )


## ----fig.height=4, fig.width=12, echo = FALSE---------------------------------
grid.arrange(p2, p3, nrow = 1)


## ----echo=TRUE, fig.height=4, fig.width=12------------------------------------
p4 <- p3 + theme(
  ### remove axis ticks
  axis.ticks=element_blank(), #<<
  ### modify axis lines
  axis.line.y = element_line(colour = "pink", size = 1, linetype = "dashed"),#<<
  axis.line.x = element_line(colour = "pink", size = 1.2, linetype = "dashed") #<<
  )


## ----echo=FALSE, fig.height=4, fig.width=12-----------------------------------
grid.arrange(p3, p4, nrow = 1)


## ----echo=TRUE, fig.height=3.5, fig.width=10----------------------------------
p5 <- p4 + 
  labs(x = "Class of car", #<<
       y = "", #<<
       title = "Cars by class and manufacturer", #<<
       subtitle = "With a custom theme!!") #<<


## ----echo=FALSE, fig.height=3.25, fig.width=10--------------------------------
grid.arrange(p4, p5, nrow = 1)


## ----echo=TRUE, fig.height=3.5, fig.width=10----------------------------------
p <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + 
  geom_point() 

p_zoom_in <- p + 
  xlim(2, 4) + #<<
  ylim(10, 25) #<<

p_zoom_out <- p + 
  scale_x_continuous(limits = c(0,7)) + #<<
  scale_y_continuous(limits = c(0, 45)) #<<


## ----echo=FALSE, fig.height=3.5, fig.width=10---------------------------------
p <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + 
  geom_point() + 
  theme(legend.position = "none") + 
  ggtitle("Default") + 
  scale_color_locuszoom() +
  theme(aspect.ratio = 1,
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        strip.text = element_text(size = 14))

p_zoom_in <- p + 
  xlim(2, 4) + 
  ylim(10, 25) + 
  ggtitle("Zoomed in")

p_zoom_out <- p + 
  scale_x_continuous(limits = c(0,7)) +
  scale_y_continuous(limits = c(0, 45)) + 
  ggtitle("Zoomed out")

grid.arrange(p, p_zoom_in, p_zoom_out, nrow = 1)


## ----fig.height=5, fig.width=8, fig.align = 'center'--------------------------
p <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + 
  geom_point() +
  scale_color_locuszoom()

library(plotly) #<<
ggplotly(p) #<<


## ----eval=FALSE---------------------------------------------------------------
## p1 <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) +
##   geom_point()
## 
## ggsave("mpg_by_wt.pdf", plot = p1) #<<


## ----echo = T, eval = F, fig.width=6, fig.height=4, fig.align = "center"------
## install.packages("palmerpenguins")
## data(penguins, package = "palmerpenguins")
## head(penguins)

