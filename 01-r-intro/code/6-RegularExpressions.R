## ----setup, include=FALSE, message=FALSE, warning = FALSE----
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)


## ------------------------------------------------------
data(state)


## ------------------------------------------------------
grep(pattern = "ne", state.name)

state.name[7]

grep(pattern = "ne", state.name, value = TRUE)



## ------------------------------------------------------
grep(pattern = "[nN]e", state.name, value = TRUE)



## ------------------------------------------------------
meta <- read.table("https://unl-statistics.github.io/R-workshops/01-r-intro/data/meta.txt")
head(meta)


## ------------------------------------------------------
meta$day <- gsub('.*D([:digit:]*)','\\1', meta$Group)
head(meta$day)

