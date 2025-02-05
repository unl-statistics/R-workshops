## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)


## ----warning=FALSE------------------------------------------------------------
library(Lahman)
LahmanData %>% head(5) %>% knitr::kable(format = "html")


## ----warning = FALSE, fig.height = 3.5, echo=TRUE-----------------------------
HallOfFame <- HallOfFame %>%
  group_by(playerID) %>% 
  mutate(times = order(yearID)) 

HallOfFame %>%
  ggplot(aes(x = yearID, y = votes/needed, colour = inducted)) + 
  geom_hline(yintercept = 1, colour = "grey20", size = .1) +
  geom_line(aes(group = playerID), colour = "black", size = 0.2) +
  geom_point() 


## ----warning = FALSE, fig.height = 3.5, echo=TRUE-----------------------------
HallOfFame %>% 
  ggplot(aes(x = times, y = votes/needed, colour = inducted)) + 
  geom_hline(yintercept = 1, colour = "grey20", size = .1) +
  geom_line(aes(group = playerID), colour = "black", size = 0.2) +
  geom_point() 


## ----eval = F, echo=TRUE------------------------------------------------------
## df1 <- data.frame(
##   id = 1:6,
##   trt = rep(c("A", "B", "C"),
##   rep=c(2,1,3)),
##   value = c(5,3,7,1,2,3))


## ----echo=FALSE---------------------------------------------------------------
df1 <- data.frame(id = 1:6, 
                  trt = rep(c("A", "B", "C"), 
                            rep=c(2,1,3)), 
                  value = c(5,3,7,1,2,3))
df1 %>% knitr::kable(format = "html")


## ----eval = F, echo=TRUE------------------------------------------------------
## df2 <- data.frame(
##   id=c(4,4,5,5,7,7),
##   stress=rep(c(0,1), 3),
##   bpm = c(65, 125, 74, 136, 48, 110))


## ----echo=FALSE---------------------------------------------------------------
df2 <- data.frame(id=c(4,4,5,5,7,7), 
                  stress=rep(c(0,1), 3), 
                  bpm = c(65, 125, 74, 136, 48, 110))

df2 %>% knitr::kable(format = "html")


## ----echo=TRUE, eval=FALSE----------------------------------------------------
## left_join(df1, df2, by="id")
## 


## ----echo=FALSE---------------------------------------------------------------
left_join(df1, df2, by="id") %>% knitr::kable(format = "html")


## ----echo=TRUE, eval = FALSE--------------------------------------------------
## inner_join(df1, df2, by = "id")


## ----echo=FALSE---------------------------------------------------------------
inner_join(df1, df2, by = "id") %>% knitr::kable(format = "html")


## ----echo=TRUE, eval=FALSE----------------------------------------------------
## full_join(df1, df2, by = "id")


## ----echo=FALSE---------------------------------------------------------------
full_join(df1, df2, by = "id") %>% knitr::kable(format = "html")


## ----echo=TRUE----------------------------------------------------------------
anti_join(df1, df2, by="id") # no values for id in df2
anti_join(df2, df1, by="id") # no values for id in df1


## ----warning = FALSE, fig.height=3, echo=TRUE---------------------------------
Batting2 <- Batting %>% group_by(playerID) %>% 
  mutate(BatAvg = H/AB) %>% 
  summarise(LifeBA = mean(BatAvg, na.rm=TRUE))

hof_bats <- inner_join(HallOfFame %>% filter(category == "Player"),
                       Batting2, by = c("playerID"))

hof_bats %>% 
  ggplot(aes(x = yearID, y = LifeBA, group = playerID)) + 
  geom_point(aes(color = inducted))



## ----fig.height=3, warning=FALSE, echo=TRUE-----------------------------------
Pitching2 <- Pitching %>% group_by(playerID) %>% 
  summarise(LifeERA = mean(ERA, na.rm = TRUE))

hof_pitch <- inner_join(HallOfFame %>% filter(category == "Player"), 
                        Pitching2, by = c("playerID"))

hof_pitch %>% 
  ggplot(aes(x = yearID, y = LifeERA, group = playerID)) + 
  geom_point(aes(color = inducted))


