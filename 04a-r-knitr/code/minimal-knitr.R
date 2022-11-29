## ----setup, include=FALSE------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(ggplot2)


## ----boring-numbers, tidy = FALSE----------------------
set.seed(1121)
x=rnorm(20)
mean(x)
var(x)


## ----boring-plots, fig.width=20, fig.height=10, out.width='.7\\linewidth', fig.cap= "it's a plot!"----

## two plots side by side
par(mfrow = c(1,2))
boxplot(x)
hist(x,main='')


