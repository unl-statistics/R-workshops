## ----setup, include=FALSE-----------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(httr)
library(rvest)
library(magrittr)


## ----nodesex, size="huge"-----------------------------------------------------------------------------------------
myurl <- "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita"
myhtml <- read_html(myurl)

myhtml %>% html_nodes("table") %>% magrittr::extract2(2) %>% html_table(header = TRUE) %>% head()



## ----textex, size="huge"------------------------------------------------------------------------------------------
myhtml %>% 
  html_nodes("p") %>% # first get all the paragraphs 
  html_nodes("a") %>% # then get all the links in those paragraphs
  html_text() # get the linked text only 


## ----tableex, size="huge"-----------------------------------------------------------------------------------------
myhtml %>% 
  html_nodes("table") %>% # get the tables 
  head(2) # look at first 2


## ----tableex2, size="huge"----------------------------------------------------------------------------------------
myhtml %>% 
  html_nodes("table") %>% # get the tables 
  magrittr::extract2(2) %>% # pick the second one to parse
  html_table(header = TRUE) # parse table 


## ----attrsex, size="huge"-----------------------------------------------------------------------------------------
myhtml %>% 
  html_nodes("table") %>% magrittr::extract2(2) %>% html_attrs()


## ----attrsex2, size="huge"----------------------------------------------------------------------------------------
myhtml %>% 
  html_nodes("p") %>% html_nodes("a") %>% html_attr("href")


## ----childex, size="huge"-----------------------------------------------------------------------------------------
myhtml %>% html_children() %>% html_name()


## -----------------------------------------------------------------------------------------------------------------
lincoln_forecasts <- 
    read_html("https://forecast.weather.gov/MapClick.php?x=177&y=197&site=oax&zmx=&zmy=&map_x=177&map_y=196#.YeBDWxPMKdY") %>%
    html_nodes(".temp") %>%
    html_text()

lincoln_forecasts

#Let's take the scrape data one step further 
#and add what we learned yesterday
library(readr)
parse_number(lincoln_forecasts)


## ----getyears, size="huge"----------------------------------------------------------------------------------------
url <- "http://avalon.law.yale.edu/subject_menus/inaug.asp"
# even though it's called "all inaugs" some are missing
all_inaugs <- (url %>% 
  read_html() %>% 
  html_nodes("table") %>% 
  html_table(fill=T, header = T)) %>% extract2(3)
# tidy table of addresses
all_inaugs_tidy <- all_inaugs %>% 
  gather(term, year, -President) %>% 
  filter(!is.na(year)) %>% 
  select(-term) %>% 
  arrange(year)
head(all_inaugs_tidy)


## ----getlinks, size="huge"----------------------------------------------------------------------------------------
# get the links to the addresses 
inaugadds_adds <- (url %>%
  read_html() %>%
  html_nodes("a") %>%
  html_attr("href"))[12:66]
# create the urls to scrape
urlstump <- "http://avalon.law.yale.edu/"
inaugurls <- paste0(urlstump, str_replace(inaugadds_adds, "../", ""))
all_inaugs_tidy$url <- inaugurls
head(all_inaugs_tidy)


## ----functiongetspeech, cache=TRUE, message = FALSE, warning = FALSE, size="huge"---------------------------------
get_inaugurations <- function(url){
  test <- try(url %>% read_html(), silent=T)
  if ("try-error" %in% class(test)) {
    return(NA)
  } else
    url %>% read_html() %>%
      html_nodes("p") %>% 
      html_text() -> address
    return(unlist(address))
}
# takes about 30 secs to run
all_inaugs_text <- all_inaugs_tidy %>% 
  mutate(address_text = (map(url, get_inaugurations))) 
all_inaugs_text$address_text[[1]]


## ----missings, size="huge"----------------------------------------------------------------------------------------
all_inaugs_text$President[is.na(all_inaugs_text$address_text)]
# there are 7 missing at this point: obama's and trump's, plus coolidge, garfield, buchanan, and van buren, which errored in the scraping.
obama09 <- get_inaugurations("http://avalon.law.yale.edu/21st_century/obama.asp")
obama13 <- readLines("speeches/obama2013.txt")
trump17 <- readLines("speeches/trumpinaug.txt")
vanburen1837 <- readLines("speeches/vanburen1837.txt") # row 13
buchanan1857 <- readLines("speeches/buchanan1857.txt") # row 18
garfield1881 <- readLines("speeches/garfield1881.txt") # row 24
coolidge1925 <- readLines("speeches/coolidge1925.txt") # row 35
all_inaugs_text$address_text[c(13,18,24,35)] <- list(vanburen1837,buchanan1857, garfield1881, coolidge1925)



## ----size="huge"--------------------------------------------------------------------------------------------------
# lets combine them all now
recents <- data.frame(President = c(rep("Barack Obama", 2), 
                                    "Donald Trump"),
                      year = c(2009, 2013, 2017), 
                      url = NA,
                      address_text = NA)

all_inaugs_text <- rbind(all_inaugs_text, recents)
all_inaugs_text$address_text[c(56:58)] <- list(obama09, obama13, trump17)
head(all_inaugs_text)


## ----textanalysis, warning = FALSE, message = FALSE, size="huge"--------------------------------------------------
# install.packages("tidytext")
library(tidytext)
presidential_words <- all_inaugs_text %>% 
  select(-url) %>% 
  unnest() %>% 
  unnest_tokens(word, address_text) 
head(presidential_words)


## ----longestspeech, warning = FALSE, message = FALSE, size="huge"-------------------------------------------------
presidential_wordtotals <- presidential_words %>% 
  group_by(President,year) %>% 
  summarize(num_words = n()) %>%
  arrange(desc(num_words))


## ----speechplot, echo = FALSE, fig.align='center', cache = T, fig.height=5, fig.width=9.5, warning = FALSE, message = FALSE, size="huge"----
library(ggrepel)
ggplot(presidential_wordtotals) + 
  geom_bar(aes(x = reorder(year, num_words), y = num_words), stat = "identity", fill = 'white', color = 'black') + 
  geom_label_repel(aes(x = reorder(year, num_words), y = num_words, label = President), size = 2.5) +
  labs(y = "Word count of Speech", x = "Year (sorted by word count)", 
       title = "Length of Presidential Inaugural Addresses", 
       subtitle = "Max: 8,459; Min: 135; Median: 2,090; Mean: 2,341") + 
  theme(axis.text.x = element_text(angle = 45, size = 7), plot.subtitle = element_text(hjust = .5))

