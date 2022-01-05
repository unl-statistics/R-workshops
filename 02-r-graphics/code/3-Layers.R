# --------------------------------------
# R PACKAGE SETUP ----------------------
# --------------------------------------
library(ggplot2)
library(patchwork)

# --------------------------------------
# HOW TO BUILD A GRAPH -----------------
# --------------------------------------

# You can add one geom per layer

p1 <- ggplot(data = mpg, aes(x = class, y = hwy)) + 
  ggtitle(label = "")

p2 <- ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_boxplot() + 
  ggtitle(label = "+ geom_boxplot()")

p3 <- ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_jitter() + 
  geom_boxplot() + 
  ggtitle(label = "+ geom_jitter() + geom_boxplot()")

grid.arrange(p1, p2, p3, ncol = 3, nrow = 1)

# YOUR TURN ------------------------------
# Change the code below to have the points **on top** of the boxplots.
ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_jitter() + 
  geom_boxplot()

# See Your Turn Solutions

# --------------------------------------
# GEOMS --------------------------------
# --------------------------------------

# geom_point()
p1 <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point() + 
  scale_color_locuszoom() + 
  scale_x_continuous(name = "city mpg") +
  scale_y_continuous(name = "highway mpg") +
  ggtitle("geom_point")

# geom_text()
p2 <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_text(aes(label = class)) + 
  scale_color_locuszoom() +
  scale_x_continuous(name = "city mpg") +
  scale_y_continuous(name = "highway mpg") +
  ggtitle("geom_text")

grid.arrange(p1, p2, ncol = 2, nrow = 1)

# --------------------------------------
# Multiple Layers ----------------------
# --------------------------------------

p1 <- ggplot(data = mpg, aes(x = class, y = hwy, colour = class)) + 
  geom_jitter(width = 0.1)

p2 <- ggplot(data = mpg, aes(x = class, y = hwy, colour = class)) + 
  geom_violin(aes(fill = class), alpha = 0.4)

p3 <- ggplot(data = mpg, aes(x = class, y = hwy, colour = class)) + 
  geom_jitter(width = 0.1) + 
  geom_violin(aes(fill = class), alpha = 0.4)

grid.arrange(p1, p2, p3, ncol = 3, nrow = 1)

# --------------------------------------
# Faceting -----------------------------
# --------------------------------------

a <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point()

b <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point() +theme(legend.position = "none") +
  facet_grid(~class)

a / b + plot_layout(widths = c(1, 7))

# --------------------------------------
# Position Adjustments -----------------
# --------------------------------------

s <- ggplot(mpg, aes(fl, fill = drv)) + 
  ggtitle("")

s1 <- s + 
  geom_bar(position = "dodge") + 
  ggtitle("position = 'dodge'")

s2 <- s + 
  geom_bar(position = "fill") + 
  ggtitle("position = 'fill'")

s3 <- s + 
  geom_bar(position = "stack") + 
  ggtitle("position = 'stack'")

s1 + s2 + s3

# --------------------------------------
# Jitter -------------------------------
# --------------------------------------

p2 <- ggplot(mpg, aes(cyl, hwy, color = factor(cyl))) + 
  geom_point() + 
  ggtitle("geom_point()")

p3 <- ggplot(mpg, aes(cyl, hwy, color = factor(cyl))) + 
  geom_point(position = "jitter") + 
  ggtitle('geom_point(position = "jitter")')

p4 <- ggplot(mpg, aes(cyl, hwy, color = factor(cyl))) + 
  geom_jitter() + 
  ggtitle("geom_jitter()")

p2 + p3 + p4

# --------------------------------------
# Coordinate Systems -------------------
# --------------------------------------

r <- ggplot(mpg, aes(fl)) + 
  geom_bar()

r1 <- r + 
  coord_cartesian(xlim = c(0, 5)) + 
  ggtitle("coord_cartesian")

r2 <- r + 
  coord_fixed(ratio = 1/10) + 
  ggtitle("coord_fixed")

r3 <- r + 
  coord_flip() + 
  ggtitle("coord_flip")

r4 <- r + 
  coord_polar(theta = "x", direction=1 ) + 
  ggtitle("coord_polar")

r5 <- r + 
  coord_trans(y = "sqrt") + 
  ggtitle("coord_trans")

world <- map_data("world")
library(maps)
worldmap <- ggplot(world, aes(x = long, y = lat, group = group)) +
  geom_path() +
  scale_y_continuous(breaks = (-2:2) * 30) +
  scale_x_continuous(breaks = (-4:4) * 45)

r7 <- worldmap + 
  coord_map("ortho") + 
  ggtitle("coord_map")

r8 <- worldmap + 
  coord_map("ortho", orientation = c(-90, 0, 0)) + 
  ggtitle("coord_map")

gridExtra::grid.arrange(r1, r2, r3, r5, r4, r7, r8, nrow = 2)

# --------------------------------------
# Maps ---------------------------------
# --------------------------------------

# Map source data
ne_counties <- map_data("county", "nebraska")
head(ne_counties)

# Population meta data
ne_population <- read.csv("https://srvanderplas.github.io/rwrks/02-r-graphics/data/nebraska-population.csv")
head(ne_population)

# Combine map source and meta data
ne_data <- left_join(ne_counties, ne_population, by = "subregion") 

# Create map with ggplot
ggplot(ne_data) +
  geom_polygon(aes(x = long, y = lat, group = group, fill = log(population)), color = "black") +
  coord_map() +
  theme_void() +
  scale_fill_gradient(low = "white", high = "green4")

# --------------------------------------
# ggplot2 Extensions -------------------
# --------------------------------------

# ggforce
library(ggforce)
ggplot(iris, aes(Petal.Length, Petal.Width, colour = Species)) +
  geom_point() +
  facet_zoom(x = Species == 'versicolor')

# ggvoronoi
library(dplyr)
library(ggvoronoi)

california <- map_data("state") %>% filter(region == "california")
ncdc.cali <- ncdc_locations %>% filter(state=="CA")

cali_map <-
  ggplot(data=ncdc.cali, aes(x = long, y = lat)) +
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
  geom_voronoi(aes(fill=elev), outline = california)
