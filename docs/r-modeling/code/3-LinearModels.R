## ----setup, include=FALSE-----------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = FALSE
)


## ----echo = F, eval = T-------------------------------------------------------
azalea <- read.csv("../data/AzaleaOneWay.csv")


## ----echo = TRUE, eval = F----------------------------------------------------
## azalea <- read.csv("https://raw.githubusercontent.com/unl-statistics/R-workshops/main/r-modeling/data/AzaleaOneWay.csv")


## ----echo = T, eval = T-------------------------------------------------------
head(azalea)


## ----echo=TRUE----------------------------------------------------------------
library(car)
#mod.fit <- lm(response ~ trt, data = data)
mod.fit <- lm(Weight ~ Trt, data = azalea)
Anova(mod.fit, type = "III")


## ----echo=TRUE----------------------------------------------------------------
library(car)
#mod.fit <- lm(response ~ trt, data = data)
azalea$Trt.new <- as.factor(azalea$Trt)
mod.fit <- lm(Weight ~ Trt.new, data = azalea)
Anova(mod.fit, type = "III")


## ----echo=TRUE----------------------------------------------------------------
library(emmeans)
emmeans(mod.fit, pairwise ~ Trt.new)


## -----------------------------------------------------------------------------
options(width = 50)


## ----echo=TRUE----------------------------------------------------------------
library(gmodels)
fit.contrast(mod.fit, "Trt.new", c(1, -1/6, -1/6, -1/6, -1/6, -1/6, -1/6))


## ----echo=TRUE----------------------------------------------------------------
fit.contrast(mod.fit, "Trt.new", c(6, -1, -1, -1, -1, -1, -1))


## ----echo = T, eval = F-------------------------------------------------------
## azalea2 <- read.csv("https://raw.githubusercontent.com/unl-statistics/R-workshops/main/r-modeling/data/AzaleaTwoWay.csv")


## ----echo = F, eval = T-------------------------------------------------------
azalea2 <- read.csv("../data/AzaleaTwoWay.csv")


## ----echo = TRUE--------------------------------------------------------------
azalea2$AppTime.new <- as.factor(azalea2$AppTime)
azalea2$AppRate.new <- as.factor(azalea2$AppRate)
mod.fit2 <- lm(Weight ~ AppTime.new + AppRate.new + AppTime.new:AppRate.new, data = azalea2)
Anova(mod.fit2, type = "III")


## ----echo=TRUE----------------------------------------------------------------
emmeans(mod.fit2, pairwise ~ AppRate.new)


## ----echo=TRUE----------------------------------------------------------------
emmeans(mod.fit2, pairwise ~ AppRate.new|AppTime.new)


## ----echo=TRUE----------------------------------------------------------------
emmeans(mod.fit2, pairwise ~ AppTime.new|AppRate.new)


## ----echo=TRUE----------------------------------------------------------------
mod.fit3 <- aov(Weight ~ AppTime.new + AppRate.new + AppTime.new:AppRate.new, data = azalea2)
summary(mod.fit3, split=list(AppRate.new = list(Linear=1, Quad=2)))


## ----echo=TRUE----------------------------------------------------------------
mod.fit4 <- lm(Weight ~ AppRate + I(AppRate^2), data = azalea2)
summary(mod.fit4)


## ----echo=TRUE----------------------------------------------------------------
mod.fit5 <- lm(Weight ~ AppTime.new + AppRate + I(AppRate^2) + AppTime.new:AppRate, data = azalea2)
summary(mod.fit5)


## ----echo = T, eval = F-------------------------------------------------------
## azalea3 <- read.csv("https://raw.githubusercontent.com/unl-statistics/R-workshops/main/r-modeling/data/AzaleaBlock.csv")


## ----echo = F, eval = T-------------------------------------------------------
azalea3 <- read.csv("../data/AzaleaBlock.csv")


## ----echo = TRUE--------------------------------------------------------------
azalea3$AppTime.new <- as.factor(azalea3$AppTime)
azalea3$AppRate.new <- as.factor(azalea3$AppRate)
azalea3$Block.new <- as.factor(azalea3$Block)
library(lme4)
mod.fit6 <- lmer(Weight ~ AppTime.new + AppRate.new + AppTime.new:AppRate.new + (1|Block.new), data = azalea3)
Anova(mod.fit3, type = "III")

