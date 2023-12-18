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
library(kableExtra)
library(ggsci)


## ----echo=FALSE, out.width="40%", fig.align = 'center', fig.cap="Confidence intervals are a range of values around the central estimate obtained from the sample data."----
knitr::include_graphics("images/confidence-interval-best-est-uncertainty.png")


## ----penguins-data, eval = T, purl = T, echo = T------------------------------
data(penguins, package = "palmerpenguins")


## ----penguins-ttest-data------------------------------------------------------
penguins2 <- penguins %>%
  select(sex, body_mass_g) %>%
  na.omit()

penguins2[1:3,] %>% kable()


## ----penguins-ttest-summary---------------------------------------------------
penguins2 %>%
  group_by(sex) %>%
  summarize(mean = mean(body_mass_g),
            sd = sd(body_mass_g)) %>% 
  kable(digits = 1)


## ----penguins-ttest-boxplot, fig.width = 6, fig.height = 6--------------------
penguins2 %>%
  ggplot(aes(x = sex, y = body_mass_g, color = sex, fill = sex)) +
  geom_boxplot(alpha = 0.1, width = 0.5) +
  geom_point(shape = 1, position = position_jitter(width = 0.2)) +
  theme_bw() +
  theme(aspect.ratio = 1,
        axis.text = element_text(size = 16),
        axis.title = element_text(size = 18),
        legend.position = "none") +
  ylab("Body Mass (g)") +
  xlab("Sex") +
  scale_color_locuszoom()  +
  scale_fill_locuszoom()




## ----penguin, equal variance, echo = T----------------------------------------
library(car)
leveneTest(penguins2$body_mass_g, group = penguins2$sex, center = mean)


## ----penguins-ttest-echo, echo = T, eval = F, purl = T------------------------
## penguins_ttest <- t.test(body_mass_g ~ sex, data = penguins2) #<<
## penguins_ttest




## ----penguins-ttest-results-echo, echo = T, eval = F, purl = T----------------
## penguins_ttest$statistic
## penguins_ttest$df
## penguins_ttest$p.value


## ----penguins-ttest-broom-echo, echo = T, eval = F, purl = T------------------
## install.packages("broom")
## library(broom)
## penguins_results <- tidy(penguins_ttest) #<<
## penguins_results




## ----penguins-ttest-graph-results-echo, echo = T, purl = T, eval = F, fig.align='center', fig.width = 7, fig.height = 3.5----
## ggplot(penguins_results, aes(x = NA, y = estimate)) +
##   geom_point(size = 2) +
##   geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = 0.2) +
##   geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
##   theme_bw() +
##   theme(aspect.ratio = 0.5, axis.text.y = element_blank()) +
##   xlab("") + ylab("Difference in Body Mass \n (Female - Male)") +
##   coord_flip()
















## ----penguins-chisq-data------------------------------------------------------
penguins3 <- penguins %>%
  select(species, island) %>%
  na.omit()

penguins3[1:3,] %>% kable()


## ----penguins-chisq-summary---------------------------------------------------
with(penguins3, table(island, species))


## ----penguins-chisq-mosaicplot, fig.height = 5.5, fig.width = 7---------------
library(ggmosaic)
ggplot(penguins3) +
  geom_mosaic(aes(x = product(island), fill = species), color = "white") +
  theme_test() +
  theme(aspect.ratio = 1,
        axis.text.y = element_blank(),
        axis.text = element_text(size = 16),
        axis.title = element_text(size = 18),
        legend.text = element_text(size = 16),
        legend.title = element_text(size = 18)) +
  ylab("Species") +
  xlab("Island") +
  scale_fill_locuszoom()




## ----penguins-chisq, echo = T, eval = T, purl = T-----------------------------
chisq.test(penguins3$island, penguins3$species) #<<
chisq.test(penguins3$island, penguins3$species, 
           simulate.p.value = T) #<<


## ----penguins-regression-data-------------------------------------------------
penguins4 <- penguins %>%
  select(body_mass_g, flipper_length_mm) %>%
  na.omit()

penguins4[1:3,] %>% kable()


## ----penguins-regression-summary----------------------------------------------
with(penguins4, cor(body_mass_g, flipper_length_mm))


## ----penguins-regression-scatterplot, fig.height = 5, fig.width = 5-----------
ggplot(penguins4, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(shape = 1) +
  geom_smooth(method = "loess") +
  theme_bw() + 
  theme(aspect.ratio = 1,
        axis.text = element_text(size = 16),
        axis.title = element_text(size = 18),
        legend.text = element_text(size = 16),
        legend.title = element_text(size = 18)) +
  ylab("Flipper Length (mm)") +
  xlab("Body Mass (g)")




## ----penguins-regression-mod, echo = T, purl = T, eval = T--------------------
penguins_regression <- lm(body_mass_g ~ flipper_length_mm, data = penguins4) #<<
summary(penguins_regression)


## ----penguins-assumptions, echo = T, purl = T, eval = T, fig.align='center', fig.align = 'center', fig.width = 6, fig.height = 6----
par(mfrow = c(2,2))
plot(penguins_regression)
par(mfrow = c(1,1))


## ----penguins-regression-results-echo, echo = T, purl = T, eval = F-----------
## tidy(penguins_regression)  %>%
##   mutate(p.value = scales::pvalue(p.value))








## ----penguins-regression-results-graph, echo = F, purl = T, eval = T, fig.align='center', fig.height = 5, fig.width = 9----
penguins_preds <- cbind(penguins4, predict(penguins_regression, interval = 'confidence'))
ggplot(penguins_preds, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(shape = 1, aes(color = "Observed")) +
  geom_line(aes(y = fit, color = "Fitted"), size = 1) +
  geom_ribbon(aes(ymin = lwr, ymax = upr, fill = "95% Confidence \n Interval"), alpha = 0.3) +
  theme_bw() + 
  theme(aspect.ratio = 1,
        axis.text = element_text(size = 16),
        axis.title = element_text(size = 18),
        legend.text = element_text(size = 16),
        legend.title = element_text(size = 18)) +
  scale_color_manual("", values = c("steelblue", "black")) +
  scale_fill_manual("", values = c("gray30")) +
  ylab("Flipper Length (mm)") +
  xlab("Body Mass (g)") 

