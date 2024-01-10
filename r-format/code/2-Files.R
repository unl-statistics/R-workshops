## ----setup, include=FALSE-----------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)



## ----eval = FALSE, echo = TRUE------------------------------------------------
## 
## #Returns the file path of the current working directory
## getwd()
## 
## #Set Working Directory
## setwd()
## 


## ----message=FALSE, warning=FALSE---------------------------------------------
library(readr)
library(knitr)
midwest <- read_csv("https://github.com/unl-statistics/R-workshops/raw/main/r-format/data/midwest.csv")
knitr::kable(head(midwest))






## ----warning=FALSE, message=FALSE, echo = TRUE--------------------------------
library(lubridate) # works with dates
library(tidyverse)
values <- c(midwest_data$X3, midwest_data$X5, midwest_data$X7, 
            midwest_data$X9, midwest_data$X11)
dates <- c(paste(midwest_data$X1, midwest_data$X2, sep = "-"), 
           paste(midwest_data$X1, midwest_data$X4, sep = "-"),
           paste(midwest_data$X1, midwest_data$X6, sep = "-"),
           paste(midwest_data$X1, midwest_data$X8, sep = "-"),
           paste(midwest_data$X1, midwest_data$X10, sep = "-"))

dates <- dates[!is.na(values)] #removing NAs
values <- values[!is.na(values)] #removing Nas

dates <- ymd(dates)

midwest_gas <- data_frame(date = dates, price = values)
midwest_gas <- arrange(midwest_gas, dates)


## ----warning=FALSE, message=FALSE, fig.width=7, fig.height=4, echo = TRUE, fig.align='center'----
library(ggplot2)

ggplot(midwest_gas, aes(x = date, y = price)) + geom_line()


## ----eval=FALSE, echo = TRUE--------------------------------------------------
## library(readxl)
## midwest2 <- read_excel("https://github.com/unl-statistics/R-workshops/raw/main/r-format/data/midwest.xls")
## head(midwest2)




## ----eval=FALSE, echo = TRUE--------------------------------------------------
## midwest2 <- read_excel("https://github.com/unl-statistics/R-workshops/raw/main/r-format/data/midwest.xls", skip = 1) #<<
## names(midwest2)[1] <- "Year-Month"
## head(midwest2)

