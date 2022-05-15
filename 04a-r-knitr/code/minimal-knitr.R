## ----setup, include=FALSE-------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----boring-numbers-------------------------------------------------------------------------------------
set.seed(1121)
x=rnorm(20)
mean(x)
var(x)


## ----boring-plots, fig.width=10, fig.height=6, out.width='.9\\linewidth'--------------------------------

## two plots side by side
par(mfrow = c(1,2))
boxplot(x)
hist(x,main='')


