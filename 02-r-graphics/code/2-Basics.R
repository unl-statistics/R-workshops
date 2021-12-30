# --------------------------------------
# R PACKAGE SETUP ----------------------
# --------------------------------------
library(ggplot2)

# --------------------------------------
# ANSCOMBE'S QUARTET -------------------
# --------------------------------------

# data
data(quartet)
head(quartet)

# summary statistics
quartet %>%
  group_by(set) %>%
  summarize(mean(x), sd(x), mean(y), sd(y), cor(x,y))

# plot
ggplot(quartet, aes(x, y)) + 
  geom_point(colour = "green4", size = 2.5) + 
  geom_smooth(method = lm, se = FALSE, colour = "gray", alpha = .5) +
  facet_wrap(~ set) +
  theme_bw() +
  theme(aspect.ratio = 1)

# --------------------------------------
# TIDY YOUR DATA -----------------------
# --------------------------------------

# data
data(french_fries, package="reshape2")

# wide format
head(french_fries)

# long format
french_fries_long <- french_fries %>% 
  pivot_longer(cols = c("potato":"painty"),
               names_to = "variable",
               values_to = "value")
head(french_fries_long)
