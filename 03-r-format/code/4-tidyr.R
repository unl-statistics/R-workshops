## ----setup, include=FALSE------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
data(french_fries, package="reshape2")


## ----echo = FALSE--------------------------------------
read.csv("../data/preg.csv")


## ----echo = FALSE--------------------------------------
read.csv("../data/preg2.csv")


## ----fig.width=3, fig.height=3.7,echo=FALSE, fig.align="center"----
library(png)
library(grid)
img <- readPNG("images/tablelong2.png")
 grid.raster(img)


## ---- echo=TRUE, eval=FALSE----------------------------
## french_fries <- read_csv("frenchfries.csv")
## head(french_fries)


## ---- echo=FALSE---------------------------------------
head(french_fries) %>% knitr::kable(format = "html")


## ---- fig.width=7, fig.height=3, warning=FALSE, echo=TRUE----
library(ggplot2)

ggplot(french_fries) + 
geom_boxplot(aes(x="1_buttery", y=buttery), fill = "cyan4") +
geom_boxplot(aes(x = "2_grassy", y = grassy), fill = "darkorange2") +
geom_boxplot(aes(x = "3_painty", y = painty), fill = "darkorchid1") +
geom_boxplot(aes(x = "4_potato", y = potato), fill = "chartreuse3") +
geom_boxplot(aes(x = "5_rancid", y = rancid), fill = "deeppink") +
xlab("variable") + ylab("rating")


## ---- echo=TRUE----------------------------------------
french_fries_long <- french_fries %>% 
  pivot_longer(cols = potato:painty, 
               names_to = "variable", 
               values_to = "rating")

french_fries_long %>% 
  head() %>% 
  knitr::kable(format = "html")



## ---- fig.width=7, fig.height=4, warning=FALSE, echo=TRUE----
ggplot(french_fries_long) + 
  geom_boxplot(aes(x = variable, y = rating, fill = variable))



## ------------------------------------------------------
head(french_fries_long, 3) %>% knitr::kable(format = "html")


## ---- warning = FALSE, echo=TRUE-----------------------
french_fries_wide <- french_fries_long %>% 
  pivot_wider(names_from = variable, 
              values_from = rating, 
              values_fill = NA)

head(french_fries_wide, 2) %>% 
  knitr::kable(format = "html")


## ------------------------------------------------------
french_fries_wide <- french_fries_long %>% 
  pivot_wider(names_from = rep, 
              values_from = rating)

head(french_fries_wide, 3) %>% 
  knitr::kable(format = "html")


## ----fig.height=4, warning=FALSE, echo=TRUE------------
french_fries_wide %>%
  ggplot(aes(x = `1`, y = `2`)) + 
  geom_point() +
  facet_wrap(~variable) + 
  geom_abline(colour = "grey50")


## ----echo=FALSE----------------------------------------
df <- 
  data.frame(states = c("Lincoln/NE", "Chicago/IL", "Ames/IA", "Nashville/TN"),
            dates = c("Aug-2000", "Sep-2001", "Oct-2002", "Feb-2001"))
df %>% knitr::kable(format = "html")


## ----echo =TRUE----------------------------------------
df <- data.frame(x = c(NA, "a.b", "a.d", "b.c"))
df
df %>% separate(x, into = c("A", "B"))


## ----echo=TRUE-----------------------------------------
df2 <- data.frame(y = c("Lincoln, NE", "Chicago, IL", "Ames, IA", "Nashville, TN"))
df2
df2 %>% separate(y, c("City", "State"), sep = ", ")


## ----echo=TRUE-----------------------------------------
url <- "https://data.iowa.gov/api/views/3adi-mht4/rows.csv"
campaign <- readr::read_csv(url)


## ----echo=TRUE-----------------------------------------
problems(campaign)


## ----echo=TRUE-----------------------------------------
campaign <- readr::read_csv(url, guess_max = 50000)


## ---- results='hold', message=FALSE, echo=TRUE---------
library(lubridate) #<< #New Package Alert!!

now()
today()
now() + hours(4)
today() - days(2)


## ---- results='hold', echo=TRUE------------------------
ymd("2013-05-14")
mdy("05/14/2013")
dmy("14052013")
ymd_hms("2013:05:14 14:50:30", tz = "America/Chicago")


## ---- echo=TRUE----------------------------------------
flights <- 
  read.csv("http://unl-statistics.github.io/R-workshops/03-r-format/data/flights.csv")






## ---- echo=TRUE----------------------------------------
billboard <- 
  read.csv("http://unl-statistics.github.io/R-workshops/03-r-format/data/billboard.csv")

