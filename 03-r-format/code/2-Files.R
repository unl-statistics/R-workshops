## ----setup, include=FALSE------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)



## ----message=FALSE, warning=FALSE----------------------
library(readr)
library(knitr)
midwest <- read_csv("http://unl-statistics.github.io/R-workshops/03-r-format/data/midwest.csv")
knitr::kable(head(midwest), format = "html")


## ---- message=FALSE, echo = TRUE-----------------------
midwest_names <- read_csv(
"http://unl-statistics.github.io/R-workshops/03-r-format/data/midwest.csv", 
  n_max= 2, col_names = FALSE) 


midwest_data <- read_csv(
"http://unl-statistics.github.io/R-workshops/03-r-format/data/midwest.csv", 
  skip = 2, col_names = FALSE) 


## ---- warning=FALSE, message=FALSE, echo = TRUE--------
library(lubridate)
library(tidyverse)
values <- c(midwest_data$X3, midwest_data$X5, midwest_data$X7, 
            midwest_data$X9, midwest_data$X11)
dates <- c(paste(midwest_data$X1, midwest_data$X2, sep = "-"), 
           paste(midwest_data$X1, midwest_data$X4, sep = "-"),
           paste(midwest_data$X1, midwest_data$X6, sep = "-"),
           paste(midwest_data$X1, midwest_data$X8, sep = "-"),
           paste(midwest_data$X1, midwest_data$X10, sep = "-"))

dates <- dates[!is.na(values)]
values <- values[!is.na(values)]

dates <- ymd(dates)

midwest_gas <- data_frame(date = dates, price = values)
midwest_gas <- arrange(midwest_gas, dates)


## ---- warning=FALSE, message=FALSE, fig.width=7, fig.height=4, echo = TRUE----
library(ggplot2)
ggplot(midwest_gas, aes(x = date, y = price)) + geom_line()


## ---- eval=FALSE, echo = TRUE--------------------------
## library(readxl)
## midwest2 <- read_excel("midwest.xls")
## head(midwest2)


## ----midwest, echo=FALSE-------------------------------
library(readxl)
midwest2 <- read_excel("../data/midwest.xls") 
knitr::kable(head(midwest2, 3), format = "html")


## ---- eval=FALSE, echo = TRUE--------------------------
## midwest2 <- read_excel("midwest.xls", skip = 1) #<<
## names(midwest2)[1] <- "Year-Month"
## head(midwest2)


## ----midwest2, echo=FALSE------------------------------
midwest2 <- read_excel("../data/midwest.xls", skip = 1) 
names(midwest2)[1] <- "Year-Month"
knitr::kable(head(midwest2, 3), format = "html")


## ----echo=TRUE-----------------------------------------
library(haven) 
sas.data <- read_xpt("../data/DEMO_G.XPT")
sas.data %>% head(2)

