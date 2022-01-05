### Graphics with ggplot2: Your Turn Solutions

# Load libraries
library(ggplot2)

# --------------------------------------------
# 1-GraphicsIntro: MAKE YOUR FIRST FIGURE ----
# --------------------------------------------

# R package and data set
head(diamonds)

# Begin with the data
ggplot(data = diamonds)

# Specify the aesthetic mappings
ggplot(data = diamonds, aes(x = carat, y = price))

# Choose a geom
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point()

# Add an aesthetic
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(aes(colour = cut))

# Add another layer
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(aes(colour = cut), size = 2, alpha = .5) +
  geom_smooth()

# Mapping aesthetics vs setting aesthetics
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(aes(colour = cut), size = 2, alpha = .5) +
  geom_smooth(aes(fill = cut), colour = "lightgrey") 

# Coordinate transformations can be specified
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(aes(colour = cut), size = 2, alpha = .5) +
  geom_smooth(aes(fill = cut), colour = "lightgrey") +
  scale_y_log10()

# Specify facet variables
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(aes(colour = cut), size = 2, alpha = .5) +
  geom_smooth(aes(fill = cut), colour = "lightgrey") +
  scale_y_log10() +
  facet_wrap(~ cut)

# --------------------------------------------
# 2-Basics: Tidy Your Data -------------------
# --------------------------------------------
# To tidy the `preg` table use `pivot_longer()` to create a long table.
preg <- tibble(pregnant = c("yes", "no"),
               male = c(NA, 10),
               female = c(20, 12))
preg

# Solution
preg_long <- preg %>%
  pivot_longer(cols = c("male", "female"),
               names_to = "sex",
               values_to = "count")
preg_long

# --------------------------------------------
# 3-Layers -----------------------------------
# --------------------------------------------

# Change the code below to have the points **on top** of the boxplots.
ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_jitter() + 
  geom_boxplot()

# Solution
ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_boxplot() +
  geom_jitter() 

# --------------------------------------------
# 4-Perception -------------------------------
# --------------------------------------------	

## Your turn 1 - diamonds
	
  # In the `diamonds` data, `clarity` and `cut` are ordinal, while 
  #`price` and `carat` are continuous. Create a graphic that gives an 
  # overview of these four variables while respecting their types.

	data(diamonds)
	
	ggplot(diamonds, aes(x = carat, y = price)) +
	  geom_point(aes(color = clarity)) + 
	  geom_smooth(aes())
	  facet_grid(~cut)
	
	
## Your turn 2 - Movies

	# The `movies` data set contains information from IMDB.com 
	# including ratings, genre, length in minutes, and year of release.
	# Explore the differences in length, rating, etc. in movie genres over time.
	# **Hint:** use faceting!
	  
	movies <- read.csv("https://srvanderplas.github.io/rwrks/02-r-graphics/data/MovieSummary.csv")
	summary(movies)
	
	ggplot(movies, aes(x = year, y = budget, group = genre, color = genre)) + 
	  geom_point()
	
	ggplot(movies, aes(x = year, y = length, group = genre, color = genre)) +
	  geom_smooth()	
	 
	ggplot(movies, aes(x = budget, y = rating, color = genre, group = genre)) + 
	  geom_point() +
	  geom_smooth()  + 
	  facet_wrap(~mpaa)
	
	ggplot(movies, aes(x = log(budget + 1), y = rating, color = genre, group = genre)) + 
	  geom_point() +
	  geom_smooth() 
	
	ggplot(movies, aes(x = genre, fill = mpaa)) + 
	  geom_bar() 
	
	ggplot(movies, aes(x = rating, group = mpaa, fill = mpaa)) + 
	  geom_density(alpha = .4) + 
	  facet_wrap(~genre, nrow = 2)


# --------------------------------------------
# 4-Polishing Plots --------------------------
# --------------------------------------------	

	# install.packages("palmerpenguins")
	data(penguins, package = "palmerpenguins")
	head(penguins)
	
	# 1. Create a scatterplot of `bill length` versus `bill width` from the `penguins` data, colored by `species`
	p0 <- ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
	  geom_point()
	p0
	
	# 2. Use the black and white theme
	p1 <- p0 + 
	  theme_bw()
	p1
	
	# 3. Clean up axis labels and include an informative title.
	p2 <- p1 +
	  scale_x_continuous("Bill Length (mm)") +
	  scale_y_continuous("Bill Depth (mm)") +
	  ggtitle("Palmer Penguins", subtitle = "Bill Size")
	p2
	
	# 4. Capitalize legend title and change the color palette from default.
	p3 <- p2 +
	  scale_color_viridis_d("Species")
	p3
	
	# 5. Move the legend to the bottom and set aspect ratio to 1.
	p4 <- p3 + 
	  theme(legend.position = "bottom",
	        aspect.ratio = 1)
	p4
	
	# 6. Save your plot to a pdf file and open it in a pdf viewer.
	ggsave(filename = "02-r-graphics/code/penguins.pdf", plot = p4)
	
	# 7. Save a png of the same scatterplot. 
	ggsave(filename = "02-r-graphics/code/diamonds.png", plot = p4)
	
	# 8. Embed the png into MS word or another editor.	 
