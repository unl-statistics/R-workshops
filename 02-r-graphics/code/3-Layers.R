## ----setup, include=FALSE------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE,
	purl = FALSE
)


## ---- echo=FALSE---------------------------------------
library(ggplot2)
library(ggsci)
library(ggthemes)
library(gridExtra)
library(patchwork)
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



## ----plots-4, fig.align='bottom', fig.height=5, fig.width=15----
p1 <- ggplot(data = mpg, aes(x = class, y = hwy)) + 
  ggtitle(label = "") +
  theme(plot.title = element_text(size = 22))

p2 <- ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_boxplot() + 
  ggtitle(label = "+ geom_boxplot()") +
  theme(plot.title = element_text(size = 22))

p3 <- ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_jitter() + 
  geom_boxplot() + 
  ggtitle(label = "+ geom_jitter() + geom_boxplot()") +
  theme(plot.title = element_text(size = 22))

grid.arrange(p1, p2, p3, ncol = 3, nrow = 1)


## ----echo=TRUE, fig.height=4, fig.width=8, purl=T, fig.align = "center"----
ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_jitter() + 
  geom_boxplot()


## ---- fig.align='top', fig.height=4, fig.width=10------
p1 <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point() + 
  scale_color_locuszoom() + 
  scale_x_continuous(name = "city mpg") +
  scale_y_continuous(name = "highway mpg") +
  ggtitle("geom_point")

p2 <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_text(aes(label = class)) + 
  scale_color_locuszoom() +
  scale_x_continuous(name = "city mpg") +
  scale_y_continuous(name = "highway mpg") +
  ggtitle("geom_text")

p1 + p2


## ---- fig.align='bottom', fig.height=5, fig.width=15----
p1 <- ggplot(data = mpg, aes(x = class, y = hwy, colour = class)) + 
  geom_jitter(width = 0.1) + 
  scale_fill_locuszoom() + 
  scale_color_locuszoom()

p2 <- ggplot(data = mpg, aes(x = class, y = hwy, colour = class)) + 
  geom_violin(aes(fill = class), alpha = 0.4) + 
  scale_fill_locuszoom() + 
  scale_color_locuszoom()

p3 <- ggplot(data = mpg, aes(x = class, y = hwy, colour = class)) + 
  geom_jitter(width = 0.1) + 
  geom_violin(aes(fill = class), alpha = 0.4) + 
  scale_fill_locuszoom() + 
  scale_color_locuszoom()

p1 + p2 + p3


## ---- fig.width=10, fig.height=4, echo = TRUE, eval=FALSE----
## ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) +
##   geom_point()


## ---- fig.width=10, fig.height=4, echo = TRUE, eval=FALSE----
## ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) +
##   geom_point() +
##   facet_grid(~class) #<<


## ---- fig.width=10, fig.height=3, fig.align = "center", echo=FALSE----
a <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point() + 
  scale_color_locuszoom() +
  theme(aspect.ratio = 1.5)

b <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point() +theme(legend.position = "none") +
  facet_grid(~class) + 
  scale_color_locuszoom() +
  theme(aspect.ratio = 1.5)

a + b + plot_layout(widths = c(1, 7))


## ----position-adj, eval = F, echo = T------------------
## ggplot(mpg, aes(fl, fill = drv)) +
##   geom_bar(position = "")` #<<


## ---- fig.width=12, fig.height=4, fig.align = "center"----

s <- ggplot(mpg, aes(fl, fill = drv)) + 
  ggtitle("") + 
  scale_fill_locuszoom()

s1 <- s + 
  geom_bar(position = "dodge") + 
  ggtitle("position = 'dodge'") + 
  theme(plot.title = element_text(size = 18))

s2 <- s + 
  geom_bar(position = "fill") + 
  ggtitle("position = 'fill'") + 
  theme(plot.title = element_text(size = 18))

s3 <- s + 
  geom_bar(position = "stack") + 
  ggtitle("position = 'stack'") + 
  theme(plot.title = element_text(size = 18))

s1 + s2 + s3


## ---- fig.width=12, fig.height=4, fig.align = "center"----
p2 <- ggplot(mpg, aes(cyl, hwy, color = factor(cyl))) + 
  geom_point() + ggtitle("geom_point()") + 
  scale_color_locuszoom() + 
  theme(plot.title = element_text(size = 18))

p3 <- ggplot(mpg, aes(cyl, hwy, color = factor(cyl))) + 
  geom_point(position = "jitter") + 
  ggtitle('geom_point(position = "jitter")') + 
  scale_color_locuszoom() + 
  theme(plot.title = element_text(size = 18))

p4 <- ggplot(mpg, aes(cyl, hwy, color = factor(cyl))) + 
  geom_jitter() + ggtitle("geom_jitter()") + 
  scale_color_locuszoom() + 
  theme(plot.title = element_text(size = 18))

p2 + p3 + p4


## ---- fig.width=10, fig.height=4, fig.align = "center", eval = FALSE----
## r <- ggplot(mpg, aes(fl)) + geom_bar()
## r + coord_cartesian(xlim = c(0, 5))
## r + coord_fixed(ratio = 1/10)
## r + coord_flip()
## r + coord_trans(y = "sqrt")
## r + coord_polar(theta = "x", direction=1 )
## z + coord_map(projection = "ortho")
## z + coord_map(projection = "ortho", orientation = c(-90, 0, 0))


## ---- fig.width=10, fig.height=5, fig.align = "center"----
r <- ggplot(mpg, aes(fl)) + geom_bar()
r1 <- r + coord_cartesian(xlim = c(0, 5)) + ggtitle("coord_cartesian")
r2 <- r + coord_fixed(ratio = 1/10) + ggtitle("coord_fixed")
r3 <- r + coord_flip() + ggtitle("coord_flip")
r4 <- r + coord_polar(theta = "x", direction=1 ) + ggtitle("coord_polar")
r5 <- r + coord_trans(y = "sqrt") + ggtitle("coord_trans")
world <- map_data("world")
library(maps)
worldmap <- ggplot(world, aes(x = long, y = lat, group = group)) +
  geom_path() +
  scale_y_continuous(breaks = (-2:2) * 30) +
  scale_x_continuous(breaks = (-4:4) * 45)
r7 <- worldmap + coord_map("ortho") + ggtitle("coord_map")
r8 <- worldmap + coord_map("ortho", orientation = c(-90, 0, 0)) + ggtitle("coord_map")

grid.arrange(r1, r2, r3, r5, r4, r7, r8, nrow = 2)


## ----ne-map-data1, echo = T, eval = F------------------
## ne_counties <- map_data("county", "nebraska")


## ----ne-map-data2, echo = F, eval = T------------------
ne_counties <- map_data("county", "nebraska")
ne_counties[1:2,] %>% knitr::kable()


## ----ne-pop1, echo = T, eval = F-----------------------
## ne_population <- read.csv("https://unl-statistics.github.io/R-workshops/02-r-graphics/data/nebraska-population.csv")


## ----ne-pop2-------------------------------------------
ne_population <- read.csv("https://unl-statistics.github.io/R-workshops/02-r-graphics/data/nebraska-population.csv")
ne_population[1:2,] %>% knitr::kable()  


## ---- combine-ne-data, echo = F------------------------
ne_data <- left_join(ne_counties, ne_population, by = "subregion") 


## ----ne-map, echo = T, eval = T, fig.align = 'center', fig.height = 4, fig.width = 10----
ggplot(ne_data) +
  geom_polygon(aes(x = long, y = lat, group = group, fill = log(population)), color = "black") +
  coord_map() +
  theme_void() +
  scale_fill_gradient(low = "white", high = "green4")


## ----facet-zoom, eval = T, echo = T, fig.width = 8, fig.height = 5, fig.align = 'center'----
library(ggforce)
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) +
  geom_point() +
  facet_zoom(x = Species == 'versicolor') #<<


## ----voronoi-plot, echo = F, fig.width = 12, fig.height = 8, fig.align = 'center'----
library(dplyr)
library(ggvoronoi)

california <- map_data("state") %>% filter(region == "california")
ncdc.cali <- ncdc_locations %>% filter(state=="CA")

cali_map <-
  ggplot(data=ncdc.cali,aes(x=long,y=lat)) +
      scale_fill_gradientn("Elevation", 
          colors=c("seagreen","darkgreen","green1","yellow","gold4", "sienna"),
          values=scales::rescale(c(-60,0,1000,2000,3000,4000))) + 
      scale_color_gradientn("Elevation", 
          colors=c("seagreen","darkgreen","green1","yellow","gold4", "sienna"),
          values=scales::rescale(c(-60,0,1000,2000,3000,4000))) + 
      coord_map() +
      theme_minimal() +
      theme(axis.text=element_blank(),
            axis.title=element_blank())

cali_map +
  geom_voronoi(aes(fill=elev),outline=california)


## ----ggridges, echo = F, eval = F----------------------
## ggplot(lincoln_weather, aes(x = `Mean Temperature [F]`, y = Month, fill = stat(x))) +
##   geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) + #<<
##   scale_x_continuous(expand = c(0, 0)) +
##   scale_y_discrete(expand = expand_scale(mult = c(0.01, 0.25))) +
##   scale_fill_viridis_c(name = "Temp. [F]", option = "C") +
##   labs(
##     title = 'Temperatures in Lincoln NE',
##     subtitle = 'Mean temperatures (Fahrenheit) by month for 2016'
##   ) +
##   theme_ridges(font_size = 13, grid = TRUE) +
##   theme(axis.title.y = element_blank())

