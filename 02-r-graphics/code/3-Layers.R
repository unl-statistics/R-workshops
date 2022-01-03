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
  geom_boxplot()

p3 <- ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_jitter() + 
  geom_boxplot()

grid.arrange(p1, p2, p3, ncol = 3, nrow = 1)

# YOUR TURN
# Change the code below to have the points **on top** of the boxplots.

ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_jitter() + 
  geom_boxplot()

# Geoms

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

# A plot may have multiple layers

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

grid.arrange(p1, p2, p3, ncol = 3, nrow = 1)

# Faceting
a <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point() + 
  scale_color_locuszoom() +
  theme(aspect.ratio = 1)

b <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point() +theme(legend.position = "none") +
  facet_grid(~class) + 
  scale_color_locuszoom() +
  theme(aspect.ratio = 1)

a / b + plot_layout(widths = c(1, 7))

# position adjustements
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

# jitter
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