## ------------------------------------------------------
library(httr)
sam <- GET("https://api.github.com/users/sctyner")
content(sam)[c("name", "company")]


## ------------------------------------------------------
sam$header[1:3]


## ---- echo=FALSE, message = FALSE, warning=FALSE-------
# hopefully no one is watching
# devtools::install_github("cpsievert/XML2R")
library(XML2R)
library(tidyverse)

#obs <- read_xml("https://gist.githubusercontent.com/cpsievert/85e340814cb855a60dc4/raw/651b7626e34751c7485cff2d7ea3ea66413609b8/mariokart.xml")
obs <- XML2Obs("https://gist.githubusercontent.com/cpsievert/85e340814cb855a60dc4/raw/651b7626e34751c7485cff2d7ea3ea66413609b8/mariokart.xml", quiet = TRUE)
data.frame(obs) %>% head()
table(names(obs)) 


## ------------------------------------------------------
head(obs) # named list of observations


## ------------------------------------------------------
collapse_obs(obs) # group into table(s) by observational name/unit


## ------------------------------------------------------
library(dplyr)
obs <- add_key(obs, parent = "mariokart//driver", recycle = "name")
collapse_obs(obs)


## ------------------------------------------------------
tabs <- collapse_obs(obs)
left_join(as.data.frame(tabs[[1]]), as.data.frame(tabs[[2]])) 


## ----include=FALSE, echo=FALSE, out.width='45%', fig.show='hold', fig.align='center'----
knitr::include_graphics(c('./images/Postman.png'), auto_pdf = FALSE)


## ------------------------------------------------------
library(jsonlite)
mario <- fromJSON("http://bit.ly/mario-json")
str(mario) 


## ------------------------------------------------------
mario$driver
mario$vehicles


## ------------------------------------------------------
vehicles <- rbind(mario$vehicles[[1]], mario$vehicles[[2]])
vehicles <- cbind(driver = mario$driver, vehicles)


## ------------------------------------------------------
workshop_commits_raw <- fromJSON("https://api.github.com/repos/heike/rwrks/commits")

