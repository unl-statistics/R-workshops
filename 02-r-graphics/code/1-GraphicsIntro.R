## ----setup, include=FALSE-------------------------------------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)


## ----setup2---------------------------------------------------------------------------------------------
library(dplyr)     # data wrangling
library(tidyr)     # data wrangling
library(ggplot2)   # creates plots
library(ggsci)     # color palette
library(gridExtra) # display multiple ggplots together
library(patchwork) # display multiple ggplots together
library(grid)      # create data sets

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



## -------------------------------------------------------------------------------------------------------
data(iris)
iris[c(1:3,50:53, 100:103),] %>% knitr::kable(row.names = F)


## ----motivating-example, fig.height=6, fig.width=10, fig.align = "center"-------------------------------
data(iris)
ggplot(data = iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, colour = Species), size = 2.5) +
  theme(axis.text = element_text(size = 14),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14)) +
  scale_color_locuszoom()


## ----beginner-plots, fig.height=4, fig.width=20, fig.pos="center"---------------------------------------
# bar chart
data(mtcars)
p1 <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(cyl))) + 
  geom_bar() + 
  scale_x_discrete("Cylinder") +
  ggtitle(label = "Bar Chart") +
  scale_fill_grey(name = "Cylinder", start = 0.2, end = 0.8) +
  theme(legend.position = "none")

# pie chart
p2 <- ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) + 
  geom_bar(width = 1) + 
  coord_polar(theta ="y") + 
  scale_x_discrete(name = "") +
  ggtitle(label = "Pie Chart") +
  scale_fill_grey(name = "Cylinder", start = 0.2, end = 0.8) +
  theme(legend.position = "none")

# histogram
p3 <- ggplot(iris, aes(x = Sepal.Length)) + 
  geom_histogram(bins = 20, color = "black", fill = "gray") + 
  scale_x_continuous(name = "") +
  ggtitle(label = "Histogram")

# scatterplot
p4 <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point() + 
  scale_x_continuous(name = "") +
  scale_y_continuous(name = "") +
  ggtitle(label = "Scatterplot")

# map
data <- data.frame(murder=USArrests$Murder, state=tolower(rownames(USArrests)))
map <- map_data("state")
map2 <- map %>% filter(region == "nebraska")
p5 <- data %>% 
  filter(state == "nebraska") %>% 
  ggplot() + 
  geom_map(aes(map_id = state), map = map2, fill = "grey33") + 
  expand_limits(x = map2$long, y = map2$lat) +
  ggtitle(label = "Map")

grid.arrange(p1, p2, p3, p4, p5, ncol = 5, nrow = 1)



## ----intermediate-plots, fig.height=4, fig.width=20, fig.pos="center", message = FALSE, warning = FALSE----
# parallel coordinate plot
iris2 <- iris %>% 
  mutate(obs = 1:nrow(iris)) %>%
  pivot_longer(cols = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
               names_to = "variable",
               values_to = "value")

i2 <- ggplot(data = iris2) + 
 geom_line(aes(x = variable, y = value, group = interaction(Species, obs), color = Species)) + 
  scale_colour_grey(start=0.2, end= 0.7) + 
  theme(legend.position = "none") + 
  labs(x="", y="", title="Parallel Coordinates")

# mosaic plot
library(ggmosaic)
i3 <- ggplot(diamonds) + 
  ggmosaic::geom_mosaic(aes(x=ggmosaic::product(color), fill = cut)) +
  scale_fill_grey(start=0.2, end= 0.7) + 
  theme(legend.position = "none") + 
  labs(x="", y="", title="Mosaic Plot")

# radar chart
# devtools::install_github("ricardo-bion/ggradar")
library(ggradar)
mtcars %>%
    tibble::rownames_to_column(var = "group") %>% 
     mutate_at(-1, funs(scales::rescale)) %>%
     tail(4) %>% select(1:10) -> mtcars_radar

i4 <- ggradar(mtcars_radar, group.line.width = .7,
   group.point.size = 2, axis.label.size = 3.5, grid.label.size = 2.5, background.circle.transparency = 0.1, plot.legend = FALSE)+
   scale_colour_grey(start=0.4, end= 0.9)+ theme(legend.position = "none") + 
   labs(x="", y="", title="Radar Charts")

# heat map
df.team_data <- expand.grid(teams = c("Team A", "Team B", "Team C", "Team D"), 
                            metrics = c("Metric 1", "Metric 2", "Metric 3", "Metric 4", "Metric 5")
                            )

# add variable: performance
set.seed(41)
df.team_data$performance <- rnorm(nrow(df.team_data))

i5 <- ggplot(data = df.team_data, aes(x = metrics, y = teams)) +
  geom_tile(aes(fill = performance)) + 
  scale_fill_distiller(palette = "Greys") + 
  theme(legend.position = "none") + 
  labs(x="", y="", title="Heat Map")

grid.arrange(i2, i3, i4, i5, ncol = 4, nrow = 1)


## ----advanced-plots, fig.height=4, fig.width=18, fig.pos="center"---------------------------------------
# density plot
a1 <- ggplot(diamonds, aes(x = depth)) +
    geom_density(aes(fill = cut), alpha = .8) +
    scale_x_continuous("", limits = c(55,70)) +
    scale_y_continuous("") +
    ggtitle("Density Plot") +
    scale_colour_grey(start=0.6, end= 0.9) + 
    scale_fill_grey(start=0.6, end= 0.9) + 
    theme(legend.position = "none")

# violin plot
a2 <- ggplot(diamonds, aes(x = cut, y = price)) + 
  geom_violin(aes(fill = cut), alpha = .8) + 
  scale_x_discrete("") +
  scale_y_continuous("") +
  ggtitle("Violin Plot") +
  scale_fill_grey(start=0.6, end= 0.9) + 
  theme(legend.position = "none")

# network plot
data(blood)
library(GGally)

edges <- cbind(as.character(blood$edges$from), as.character(blood$edges$to))
codes <- unique(c(blood$edges$from, blood$edges$to))  # All available blood type codes
A <- matrix(0, nrow=length(codes), ncol=length(codes), dimnames=list(codes, codes))
A[edges] <- 1

a3 <- ggnet2(A, 
             node.size = 14, 
             node.color = "gray",
             node.label = codes,
             edge.size = 0.5, 
             edge.color = "gray") +
  theme_net() +
  theme(legend.position = "none") +
  ggtitle(label = "Network Plot")

# devtools::install_github("sctyner/geomnet")
# library(geomnet)
# a3 <- ggplot(data = blood$edges, aes(from_id = from, to_id = to)) +
#   geom_net(vertices = blood$vertices, aes(colour=..type..)) +
#   theme_net() +
#   scale_colour_grey(start=0.4, end= 0.9) + 
#   theme(legend.position = "none") + 
#   scale_x_continuous(name = "") +
#   scale_y_continuous(name = "") +
#   ggtitle(label = "Network Plot")

grid.arrange(a1, a2, a3, ncol = 3, nrow = 1)


## ----plots-3, fig.align='bottom', fig.height=5, fig.width=15--------------------------------------------
data(diamonds)

# bar chart
gg1 <- ggplot(diamonds, aes(cut, fill=cut)) + 
  geom_bar() + 
  scale_x_discrete("") +
  ggtitle(label = "Bar Chart", subtitle = "Cartesian coordinates") +
  scale_fill_locuszoom() +
  theme(aspect.ratio = 1)

# stacked bar chart
gg2 <- ggplot(diamonds, aes(x = factor(1), fill=cut)) + 
  geom_bar(width = 1) + 
  scale_x_discrete("") +
  ggtitle(label = "Fill-Bar", subtitle = "Cartesian coordinates") +
  scale_fill_locuszoom() +
  theme(aspect.ratio = 1)

# pie chart
gg3 <- ggplot(diamonds, aes(x = factor(1), fill=cut)) + 
  geom_bar(width=1) + 
  coord_polar(theta = "y") + 
  scale_x_discrete("") +
  ggtitle(label = "Fill-Bar", subtitle = "Polar coordinates") +
  scale_fill_locuszoom() +
  theme(aspect.ratio = 1)

grid.arrange(gg1, gg2, gg3, ncol = 3, nrow = 1)


## ----gg-layers, fig.align='top', fig.height=5, fig.width=15---------------------------------------------
grid.arrange(gg1, gg2, gg3, ncol = 3, nrow = 1)


## ----echo = TRUE, eval = F------------------------------------------------------------------------------
## library(ggplot2) #<<
## head(diamonds) #<<


## ----echo = F, eval = T---------------------------------------------------------------------------------
library(ggplot2)
head(diamonds) %>% knitr::kable()


## ---- fig.width=10, fig.height=5, echo = TRUE-----------------------------------------------------------
ggplot(data = diamonds) #<<


## ---- eval=FALSE, fig.height=5, fig.width=10, echo = TRUE-----------------------------------------------
## ggplot(data = diamonds, aes(x = carat, y = price)) #<<
## 


## ---- echo=FALSE, fig.height=5, fig.width=10------------------------------------------------------------
ggplot(data = diamonds, aes(x = carat, y = price))+ scale_fill_locuszoom()


## ---- eval=FALSE, fig.width=10, fig.height=5, echo = TRUE-----------------------------------------------
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point() #<<


## ---- echo=FALSE, fig.width=10, fig.height=5------------------------------------------------------------
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point() + 
    scale_color_locuszoom()


## ---- eval=FALSE, fig.width=10, fig.height=5, echo = TRUE-----------------------------------------------
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point(aes(colour = cut)) #<<


## ---- echo=FALSE, fig.width=10, fig.height=5------------------------------------------------------------
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut)) + 
    scale_color_locuszoom()


## ---- eval = FALSE, fig.width=10, fig.height=5, echo = TRUE---------------------------------------------
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point(aes(colour = cut)) +
##     geom_smooth() #<<


## ---- echo = FALSE, fig.width=10, fig.height=5----------------------------------------------------------
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut)) +
    geom_smooth() + 
    scale_color_locuszoom()


## ---- fig.width=10, fig.height=5, eval = FALSE, echo = TRUE---------------------------------------------
## ggplot(data = diamonds, aes(x = carat, y = price) +
##     geom_point(aes(colour = cut), size = 2, alpha = .5) + #<<
##     geom_smooth(aes(fill = cut), colour = "lightgrey") #<<


## ---- fig.width=10, fig.height=5, echo = FALSE----------------------------------------------------------
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut), size = 2, alpha = .5) + 
    scale_color_locuszoom() + 
    scale_fill_locuszoom() +
    geom_smooth(aes(fill = cut), colour = "lightgrey")


## ---- fig.width=10, fig.height=5, eval = FALSE, echo = TRUE---------------------------------------------
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point(aes(colour = cut), size = 2, alpha = .5) +
##     geom_smooth(aes(fill = cut), colour = "lightgrey") +
##     scale_y_log10() #<<


## ---- fig.width=10, fig.height=5, echo = FALSE----------------------------------------------------------
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut), size = 2, alpha = .5) +
    geom_smooth(aes(fill = cut), colour = "lightgrey") +
    scale_color_locuszoom() + 
    scale_fill_locuszoom() + 
    scale_y_log10()


## ---- fig.width=10, fig.height=5, eval = FALSE, echo = TRUE---------------------------------------------
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point(aes(colour = cut), size = 2, alpha = .5) +
##     geom_smooth(aes(fill = cut), colour = "lightgrey") +
##     scale_y_log10() +
##     facet_wrap(~cut) #<<


## ---- fig.width=10, fig.height=5, echo = FALSE----------------------------------------------------------
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut), size = 2, alpha = .5) +
    geom_smooth(aes(fill = cut), colour = "lightgrey") +
    scale_color_locuszoom() + 
    scale_fill_locuszoom() +
    scale_y_log10() +
    facet_wrap(~cut)

