## ----setup, include=FALSE------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)
library(tidyverse)


## ----pkgs, echo = T, purl = T, eval = T----------------
library('lme4')
library('emmeans')






## ---- insects-data-echo, echo = T, purl = T, eval = F----
## insects_data <- read_csv("https://unl-statistics.github.io/R-workshops/06-r-modeling/data/insects.csv")
## head(insects_data)


## ---- insects-data, echo = F, eval = T-----------------
insects_data <- read_csv("https://unl-statistics.github.io/R-workshops/06-r-modeling/data/insects.csv")
insects_data[1:4,] %>% kable()


## ----deposit-summary, echo = F, purl = T, eval = T-----
factorCols <- c("Rep", "Insecticide")
insects_data[,factorCols] <- lapply(insects_data[,factorCols], factor)
summary(insects_data)


## ----deposit-graph-eda, echo = F, purl = T, eval = T, fig.align = 'center', fig.height = 4, fig.width = 9----
ggplot(data = insects_data, aes(x = Deposit, y = Killed/Number)) +
  geom_point(position = position_jitter(width = 0.2, height = 0)) +
  geom_smooth(method = "loess") +
  facet_grid(~Insecticide) +
  theme_bw() +
  theme(aspect.ratio = 1)


## ----deposit-glm, echo = T, eval = T-------------------
 insects_glm <- glm(Killed/Number ~ Insecticide*Deposit + Insecticide*I(Deposit^2),
     weights = Number, #<<
     data = insects_data,
     family = "binomial") #<<
car::Anova(insects_glm)


## ----insects-summary, echo = T, eval = T, purl = T-----
summary(insects_glm)


## ----insects-emmeans-echo, echo = T, eval = F, purl = T----
## insects_emmeangrid <- ref_grid(insects_glm, at = list(Deposit = unique(insects_data$Deposit))) #<<
## insects_emmeans <- emmeans(insects_emmeangrid, specs =~Insecticide:Deposit, type = "response")
## insects_emmeans




## ----insects-pairs, echo = T, eval = T, purl = T-------
insects_pairs <- emmeans(insects_emmeangrid, specs =~Insecticide | Deposit, type = "response")
pairs(insects_pairs, infer = c(T,T))


## ----insecticide-plot-echo, echo = T, eval = F, purl = T----
## insects_predgrid <- ref_grid(insects_glm, at = list(Deposit = seq(min(insects_data$Deposit), max(insects_data$Deposit), 0.2)))
## insects_preds <- emmeans(insects_predgrid, specs =~Insecticide:Deposit, type = "response")
## insects_preds




## ----insects-plot-echo, echo = T, eval = F, purl = T----
## insects_preds %>%
##   as_tibble() %>%
##   ggplot(aes(x = Deposit, shape = Insecticide, color = Insecticide, fill = Insecticide)) +
##   geom_line(aes(y = prob)) + #<<
##   geom_ribbon(aes(ymin = asymp.LCL, ymax = asymp.UCL), color = NA, alpha = 0.2) + #<<
##   geom_point(data = insects_data, aes(y = Killed/Number), position = position_jitter(width = 0.2, height = 0)) + #<<
##   theme_bw() +
##   theme(aspect.ratio = 1) +
##   scale_color_locuszoom() +
##   scale_fill_locuszoom() +
##   scale_y_continuous("Mortality (%)", labels = scales::percent)




## ----birds-data-echo, echo = T, purl = T, eval = F-----
## birds_data <- read_csv("https://unl-statistics.github.io/R-workshops/06-r-modeling/data/birds.csv")
## head(birds_data)




## ----birds-data2, echo = T, purl = T, eval = T---------
summary(birds_data)
factorCols <- c("Site", "Habitat")
birds_data[,factorCols] <- lapply(birds_data[,factorCols], factor)
summary(birds_data)


## ----birds-graph-eda1, fig.height = 3, fig.width = 8, fig.align='center'----
ggplot(data = birds_data, aes(x = Count, fill = Habitat)) +
  geom_histogram( color = "black") +
  facet_wrap(~Habitat, ncol = 2) +
  theme_bw() +
  theme(aspect.ratio = 1,
        axis.text = element_text(size = 18),
        axis.title = element_text(size = 24)) +
  scale_fill_locuszoom()


## ----birds-graph-eda2, fig.height = 3, fig.width = 8, fig.align='center'----
ggplot(data = birds_data, aes(x = log(Count), fill = Habitat)) +
  geom_histogram( color = "black") +
  facet_wrap(~Habitat, ncol = 2) +
  theme_bw() +
  theme(aspect.ratio = 1,
        axis.text = element_text(size = 18),
        axis.title = element_text(size = 24)) +
  scale_fill_locuszoom()


## ----birds-glmer, echo = T, eval = T, purl = T---------
library(optimx)
birds_nb <- glmer.nb(Count ~ Habitat + (1|Site),
                     data = birds_data,
                     nAGQ = 100)
car::Anova(birds_nb)


## ----birds-results, echo = T, eval = T, purl = T-------
summary(birds_nb)


## ----birds-emmeans-echo, echo = T, eval = F, purl = T----
## birds_emmeans <- emmeans(birds_nb, specs = ~ Habitat,
##                          type = "response") #<<
## birds_emmeans




## ----birds-pairs-echo, echo = T, eval = T, purl = T----
pairs(birds_emmeans, infer = c(T,T))


## ----birds-groups-echo, echo = T, eval = F, purl = T----
## library(multcomp)
## library(multcompView)
## library(stringr)
## birds_letters <- cld(birds_emmeans, Letters = letters, alpha = 0.5) %>% #<<
##   mutate(.group = toupper(str_trim(.group))) #<<
## birds_letters




## ----birds-plot-echo, echo = T, eval = F, purl = T, fig.align='center',fig.height=5, fig.width=5----
## birds_letters %>%
##   as_tibble() %>% #<<
##   ggplot(aes(x = Habitat, y = response)) +
##   geom_point() +
##   geom_errorbar(aes(ymin = asymp.LCL, ymax = asymp.UCL), width = 0.1) +
##   geom_text(aes(label = .group, y = asymp.UCL), vjust = -0.5, size = 6) + #<<
##   geom_point(data = birds_data, aes(y = Count), shape = 1, position = position_jitter(width = 0.2, height = 0)) + #<<
##   theme_bw() +
##   theme(aspect.ratio = 1) +
##   ylab("Number of Birds")

