## ----setup, include=FALSE-----------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)
library(tidyverse)
library(knitr)
library(ggsci)


## ----eda-example-echo, echo = T, eval = F, purl = T---------------------------
## install.packages("palmerpenguins")
## data(penguins, package = "palmerpenguins")
## head(penguins)




## ----numerical-summaries-echo, purl = T, echo = T, eval = F-------------------
## penguins %>%
##   group_by(sex) %>%
##   summarize(across(c("body_mass_g"),
##                    list(Mean = ~ mean(., na.rm = T),
##                         SD = ~ sd(., na.rm =T),
##                         Min = ~ min(., na.rm = T),
##                         Median = ~ median(., na.rm = T),
##                         Max = ~ max(., na.rm = T))))




## ----graphical-summaries-echo, purl = T, echo = T, eval = F-------------------
## penguins %>%
##   ggplot(aes(x = sex, y = body_mass_g, color = sex, fill = sex)) +
##   geom_boxplot(alpha = 0.5) +
##   geom_point(position = "jitter", alpha = 0.7) +
##   theme_bw() +
##   theme(aspect.ratio = 1)

