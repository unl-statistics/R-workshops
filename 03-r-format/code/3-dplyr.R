## ----setup, include=FALSE-----------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
data(baseball, package = "plyr")


## ----message = FALSE, warning=FALSE, echo = FALSE-----------------------------------------------------------------
library(tidyverse)
pitch <- read_csv("http://srvanderplas.github.io/rwrks/03-r-format/data/pitch.csv")
pitch %>% 
  filter(pitcher_hand == "R", pitch_type == "CU") %>%
  head()







## ----arr.desc-----------------------------------------------------------------------------------------------------
pitch %>% 
  subset(select = c("playerid", "spin_rate")) %>%
  arrange(desc(playerid), spin_rate) %>% 
  head(5)


## ----arr.asce-----------------------------------------------------------------------------------------------------
pitch %>% 
  subset(select = c("playerid", "spin_rate")) %>%
  arrange(playerid, spin_rate) %>% 
  head(5)






## -----------------------------------------------------------------------------------------------------------------
pitch %>% 
  select(playerid, pitcher_hand, action_result, spin_rate) %>%
  head()
  


## -----------------------------------------------------------------------------------------------------------------
pitch %>%
    summarise(mean_spinrate = mean(spin_rate, na.rm=TRUE), 
              sd_spinrate = sd(spin_rate, na.rm = TRUE))


## -----------------------------------------------------------------------------------------------------------------
pitch %>%
    group_by(playerid) %>%
    summarise(mean_spinrate = mean(spin_rate, na.rm=TRUE), 
              sd_spinrate = sd(spin_rate, na.rm = TRUE))




## -----------------------------------------------------------------------------------------------------------------
pitch %>%
    select(playerid, spin_rate, action_result) %>%
    group_by(playerid, action_result) %>%
    summarise(mean_spin = mean(spin_rate), sd_spin = sd(spin_rate)) %>%
    mutate(mean = sum(mean_spin) / n()) %>%
    mutate(difference = mean - mean_spin)


## -----------------------------------------------------------------------------------------------------------------
pitch %>% 
  select(pitcher_hand) %>% mutate(Handedness = ifelse(pitcher_hand == "R", "Right", "Left"))



## -----------------------------------------------------------------------------------------------------------------
pitch$mean_spin


## -----------------------------------------------------------------------------------------------------------------
pitch$mean_spin <- mean(pitch$spin_rate)


## ---- eval = FALSE------------------------------------------------------------------------------------------------
## 
## pitch %>% tally()
## pitch %>% summarize(n=n())
## 


## ---- eval=FALSE--------------------------------------------------------------------------------------------------
## pitch %>% count(playerid, action_result)
## pitch %>% group_by(playerid, action_result) %>% summarize(n=n())
## 
















## ----warning=FALSE------------------------------------------------------------------------------------------------
ChickPlus <- ChickWeight %>% 
  group_by(Chick) %>% 
  mutate(gain = weight - weight[Time == 0])


## ----echo=FALSE, eval=FALSE---------------------------------------------------------------------------------------
## ChickPlus %>%
##   filter(Chick == 1) %>%
##   select(-Diet) %>%
##   glimpse()




## ----fig.height=4-------------------------------------------------------------------------------------------------
ChickPlus %>% 
  ggplot(aes(x = Time, y = gain, group = Chick)) + 
  geom_line(aes(color=Diet)) +
  facet_wrap(~Diet)


