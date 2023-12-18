## ----eval=FALSE---------------------------------------------------------------
## install.packages("tidyverse")
## library(tidyverse)


## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
library(tidyverse)


## ----message=FALSE, warning=FALSE, echo=TRUE----------------------------------
shed <- read_csv("https://unl-statistics.github.io/R-workshops/01-r-intro/data/daily_shedding.csv")


## -----------------------------------------------------------------------------
head(shed)


## -----------------------------------------------------------------------------
str(shed)


## ----height = 3000------------------------------------------------------------
summary(shed)


## ----fig.height=5, fig.width=8------------------------------------------------
ggplot(shed, aes(x=time_point, y=total_shedding)) + geom_point()


## ----fig.height=5, fig.width=9------------------------------------------------
ggplot(shed, aes(x=time_point, y=total_shedding, colour = treatment)) + geom_point()


## ----fig.height=5, fig.width=9------------------------------------------------
ggplot(shed, aes(x=time_point, y=total_shedding, colour = treatment)) + geom_line(aes(group=pignum))


## ----fig.height=5, fig.width=9------------------------------------------------
ggplot(shed, aes(x=time_point, y=total_shedding, color=treatment)) + 
  geom_line(aes(group=pignum)) + 
  facet_wrap(~treatment)


## -----------------------------------------------------------------------------
final_shed <- shed %>% 
  group_by(pignum) %>% 
  mutate(gain = pig_weight[time_point == 21] - pig_weight[time_point == 0]) %>% filter(time_point == 21) %>% ungroup() %>% select(-c(4:9))

summary(final_shed$gain)


## ----fig.height=5, fig.width=8------------------------------------------------
ggplot(final_shed) + geom_histogram(aes(x = total_shedding))


## -----------------------------------------------------------------------------
final_shed[which.min(final_shed$total_shedding),]


## -----------------------------------------------------------------------------
# Using base `R`:
median(final_shed$total_shedding[final_shed$treatment == "control"])
# then repeat for each treatment. Or ...

# Using `tidyverse`:
final_shed %>%  group_by(treatment) %>% 
  summarise(med_shed = median(total_shedding))


## -----------------------------------------------------------------------------
wilcox.test(total_shedding ~ treatment, data = final_shed,
            subset = treatment %in% c("control", "RPS"))


## ----fig.height=5, fig.width=9------------------------------------------------
ggplot(final_shed) + 
  geom_boxplot( aes(treatment, total_shedding, fill = treatment))


## ----fig.height=4, fig.width=9------------------------------------------------
shed %>% filter(time_point != 0) %>% ggplot() + 
  geom_boxplot( aes(treatment, daily_shedding, fill = treatment), position = "dodge")  + 
  facet_wrap(~time_point)

