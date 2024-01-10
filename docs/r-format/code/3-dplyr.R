## ----setup, include=FALSE-----------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)
data(baseball, package = "plyr")


## ----message = FALSE, warning=FALSE, echo = TRUE, eval = FALSE----------------
## library(tidyverse)
## pitch <-
##   read_csv("https://raw.githubusercontent.com/unl-statistics/R-workshops/main/r-format/data/pitch.csv")
## 
## pitch[-1] %>%
##   filter(pitcher_hand == "R", pitch_type == "CU") %>%
##   head(n=4)
## 


## ----message = FALSE, warning=FALSE, echo = FALSE-----------------------------
library(tidyverse)
pitch <- read_csv("https://raw.githubusercontent.com/unl-statistics/R-workshops/main/r-format/data/pitch.csv")
pitch[-1] %>% 
  filter(pitcher_hand == "R", pitch_type == "CU") %>%
  head(n=4) %>%
  knitr::kable(format = "html")





## ----arr.desc, echo=TRUE, eval = FALSE----------------------------------------
## pitch %>%
##   subset(select = c("playerid", "spin_rate")) %>%
##   arrange(desc(playerid), spin_rate)


## ----arr.desc2, echo=FALSE, eval = TRUE---------------------------------------
pitch %>% 
  subset(select = c("playerid", "spin_rate")) %>%
  arrange(desc(playerid), spin_rate) %>% 
  head(5) %>% knitr::kable(format = "html")


## ----arr.asc, echo=TRUE, eval = FALSE-----------------------------------------
## pitch %>%
##   subset(select = c("playerid", "spin_rate")) %>%
##   arrange(playerid, spin_rate)


## ----arr.asc2, echo=FALSE, eval = TRUE----------------------------------------
pitch %>% 
  subset(select = c("playerid", "spin_rate")) %>%
  arrange(playerid, spin_rate) %>% 
  head(5) %>% knitr::kable(format = "html")










## ----echo=TRUE, eval = FALSE--------------------------------------------------
## pitch %>%
##   select(playerid, pitcher_hand, action_result, spin_rate) %>%
##   head()
## 


## ----echo=FALSE, eval = TRUE--------------------------------------------------
pitch %>% 
  select(playerid, pitcher_hand, action_result, spin_rate) %>%
  head() %>% 
  knitr::kable(format = "html")
  


## ----echo=TRUE, eval = FALSE--------------------------------------------------
## 
## #na.rm - remove NAs from calculation
## 
## pitch %>%
##     summarise(mean_spinrate = mean(spin_rate, na.rm=TRUE),
##               sd_spinrate = sd(spin_rate, na.rm = TRUE))
## 


## ----echo=FALSE, eval = TRUE--------------------------------------------------

pitch %>%
    summarise(mean_spinrate = mean(spin_rate, na.rm=TRUE), 
              sd_spinrate = sd(spin_rate, na.rm = TRUE)) %>% 
  knitr::kable(format = "html")



## ----echo = TRUE, eval = FALSE------------------------------------------------
## pitch %>%
##     group_by(playerid) %>%
##     summarise(mean_spinrate = mean(spin_rate, na.rm=TRUE),
##               sd_spinrate = sd(spin_rate, na.rm = TRUE)) %>%
##   head(5)
## 


## ----echo = FALSE, eval = TRUE------------------------------------------------
pitch %>%
    group_by(playerid) %>%
    summarise(mean_spinrate = mean(spin_rate, na.rm=TRUE), 
              sd_spinrate = sd(spin_rate, na.rm = TRUE)) %>% 
  head(5) %>%
  knitr::kable(format = "html")





## ----echo = TRUE--------------------------------------------------------------
pitch %>%
    select(playerid, spin_rate, action_result) %>%
    group_by(playerid, action_result) %>%
    summarise(mean_spin = mean(spin_rate), 
              sd_spin = sd(spin_rate)) %>%
    mutate(mean = sum(mean_spin) / n()) %>%
    mutate(difference = mean - mean_spin) %>% head()


## ----echo=TRUE----------------------------------------------------------------
pitch %>% 
  select(pitcher_hand) %>% 
  mutate(Handedness = ifelse(pitcher_hand == "R", "Right", "Left")) %>% head()



## ----echo=TRUE----------------------------------------------------------------
pitch$mean_spin


#Columns in our dataset
colnames(pitch[,-1])


## ----echo=TRUE----------------------------------------------------------------
pitch$mean_spin <- mean(pitch$spin_rate)


## ----eval = FALSE, echo = TRUE------------------------------------------------
## 
## pitch %>% tally()
## pitch %>% summarize(n=n())
## 


## ----eval=FALSE, echo = TRUE--------------------------------------------------
## pitch %>% count(playerid, action_result)
## pitch %>% group_by(playerid, action_result) %>% summarize(n=n())
## pitch %>% group_by(playerid, action_result) %>% tally()




## ----echo = FALSE-------------------------------------------------------------
SScurve %>% head(4) %>% knitr::kable(format = "html")















## ----warning=FALSE, echo=TRUE-------------------------------------------------
ChickPlus <- ChickWeight %>% 
  group_by(Chick) %>% 
  mutate(gain = weight - weight[Time == 0])




## ----fig.height=4,echo=TRUE---------------------------------------------------
ChickPlus %>% 
  ggplot(aes(x = Time, y = gain, group = Chick)) + 
  geom_line(aes(color=Diet)) +
  facet_wrap(~Diet)


