instructors <- 3
hours <- 7*4
pay_rate <- 15
n_participants <- 10
instructors*hours*pay_rate/n_participants


library(googlesheets4)
url <- "https://docs.google.com/spreadsheets/d/1vMJMbiMJVTmMT7BRoKJLC7o2s1so30ftOXP2QtqwpmY/edit#gid=670390953"
res <- read_sheet(url)

library(tidyverse)

max_workshops <- 4
week_price <- 120
workshop_price <- 40

res <- res %>% mutate(
  courses = `Sign me up for the following workshops:` %>% 
    str_remove_all(" \\(Jan \\d{1,2}\\)") %>% 
    str_split(", ") %>% 
    purrr::map_int(length),
  fee = ifelse(courses == max_workshops, week_price, courses*workshop_price))

# Approx hourly rate, not including no-shows and scholarships.
scholarships <- 120 + 60
(sum(res$fee)-scholarships)/(instructors*hours)
