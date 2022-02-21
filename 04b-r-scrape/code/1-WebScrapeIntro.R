install.packages(c("rvest", "httr", "magrittr"))
library(tidyverse)
library(httr)
library(rvest)
library(magrittr)

### Basic Selector Gadget Example
url <- "http://www.baseball-reference.com/players/a/"
html <- read_html(url)
html %>% html_nodes("strong a") %>% html_text()