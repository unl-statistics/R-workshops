## ----setup, include=FALSE-------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(httr)
library(rvest)
library(magrittr)


## ----echo=FALSE, out.width='33%', fig.show='hold', fig.align='default'----------------------------------
knitr::include_graphics(c('./images/gdpss.png','./images/cropsss.png','./images/gass.png'), auto_pdf = FALSE)


## ----echo=FALSE, out.width='50%', fig.show='hold', fig.align='center'-----------------------------------
knitr::include_graphics("./images/copypastesucks.png", auto_pdf = FALSE)


## ----echo=FALSE, out.width='45%', fig.show='hold', fig.align='center'-----------------------------------
knitr::include_graphics(c('./images/baseball_reference.png'), auto_pdf = FALSE)


## -------------------------------------------------------------------------------------------------------
url <- "http://www.baseball-reference.com/players/a/"
html <- read_html(url)
html %>% html_nodes("strong a") %>% html_text()

