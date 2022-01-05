# --------------------------------------
# R PACKAGE SETUP ----------------------
# --------------------------------------
library(ggplot2)

# --------------------------------------
# SWIMMING CASE STUDY ------------------
# --------------------------------------

# data set
swimming <- read.csv("https://srvanderplas.github.io/rwrks/02-r-graphics/data/gestalt-swimming.csv")
factorCols <- c("Location", "WaterTemp", "Time")
swimming[,factorCols] <- lapply(swimming[,factorCols], factor)
summary(swimming)

# RQ: Does the average body temperature recovery as recorded at the four body points depend on water temperature?

ggplot(data = swimming, aes(x = Time, y = AvgTemp)) +
  geom_bar(stat = "identity", position = "dodge", aes(fill = WaterTemp), color = "black") +
  facet_grid(~Location)

ggplot(data = swimming, aes(x = WaterTemp, y = AvgTemp)) +
  geom_bar(stat = "identity", position = "dodge", aes(fill = Time), color = "black") +
  facet_grid(~Location) +
  scale_fill_brewer()

ggplot(data = swimming, aes(x = Time, y = AvgTemp)) +
  geom_point(aes(color = WaterTemp)) +
  facet_grid(~Location) 

ggplot(data = swimming, aes(x = Time, y = AvgTemp, color = WaterTemp)) +
  geom_point() +
  geom_line(aes(group = WaterTemp)) +
  facet_grid(~Location)

# --------------------------------------
# FACTORS VS CONTINUOUS VARIABLES ------
# --------------------------------------

p1 <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = class)) + 
  geom_point() + 
  scale_color_locuszoom() +
  labs(x = "city mpg", y = "highway mpg", title = "Factor variable")

p2 <- ggplot(data = mpg, aes(x = cty, y = hwy, colour = hwy)) + 
  geom_point() + 
  labs(x = "city mpg", y = "highway mpg", title = "Continuous variable")

grid.arrange(p1, p2, ncol = 2, nrow = 1)

# --------------------------------------
# COLOR IN GGPLOT2 ---------------------
# --------------------------------------

library(ggsci)
library(viridis)
library(wesanderson)
library(RColorBrewer)

p1 <- ggplot(data = mpg, aes(x = class, fill = class)) + 
  geom_bar() +
  theme_bw() +
  theme(legend.position = "none")

p11 <- p1 + labs(title= "ggplot2 default")

p2  <- p1 + scale_fill_npg() + labs(title = "NPG")

p3  <- p1 + scale_fill_startrek() + labs(title = "Star Trek")

p4  <- p1 + scale_fill_ucscgb() + labs(title = "UCSCGB")

p5  <- p1 + scale_fill_viridis(discrete = TRUE) + labs(title = "Viridis")

p6  <- p1 + scale_fill_viridis(option="magma", discrete = TRUE) + labs(title = "Magma")

p7  <- p1 + scale_fill_brewer(palette="Set2") + labs(title = "Set2")

p8  <- p1 + scale_fill_brewer(palette="Dark2") + labs(title = "Dark2")

grid.arrange(p11, p2, p3, p4, p5, p6, p7, p8, nrow = 2)

# --------------------------------------
# YOUR TURN - DIAMONDS -----------------
# --------------------------------------
# In the `diamonds` data, `clarity` and `cut` are ordinal, while 
#`price` and `carat` are continuous. Create a graphic that gives an 
# overview of these four variables while respecting their types.

data(diamonds)

# --------------------------------------
# YOUR TURN - MOVIES -------------------
# --------------------------------------
# The `movies` data set contains information from IMDB.com 
# including ratings, genre, length in minutes, and year of release.
# Explore the differences in length, rating, etc. in movie genres over time.
# **Hint:** use faceting!

movies <- read.csv("https://srvanderplas.github.io/rwrks/02-r-graphics/data/MovieSummary.csv")


