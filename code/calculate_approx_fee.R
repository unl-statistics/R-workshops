# This bit extracts the pricing code from pricing.qmd and runs it
# https://stackoverflow.com/questions/77155672/extract-setup-code-chunk-from-qmd-file-and-execute-source-it
library(parsermd)
rmd <- parse_rmd("pricing.qmd")
pricing_chunk <- rmd_select(rmd, "pricing-schedule") |> 
  as_document()
pricing_chunk <- pricing_chunk[-grep("```", pricing_chunk)]
eval(parse(text = pricing_chunk))         

# Calculate out rough pay rate
instructors <- 3
n_participants <- 17.5
hours <- 7*n_days
pay_rate <- base_rate * (n_days-discount) * n_participants/(instructors*hours)

pay_rate

# Calculate out more precisely(ish) 
## TODO - factor in affiliate/corporate status

library(googlesheets4)
url <- "https://docs.google.com/spreadsheets/d/1vMJMbiMJVTmMT7BRoKJLC7o2s1so30ftOXP2QtqwpmY/edit#gid=670390953"
res <- read_sheet(url)

library(tidyverse)

max_workshops <- n_days
week_price <- (n_days - discount) * base_rate
workshop_price <- base_rate

res <- res %>% mutate(
  courses = `Sign me up for the following workshops:` %>% 
    str_remove_all(" \\(Jan \\d{1,2}\\)") %>% 
    str_split(", ") %>% 
    purrr::map_int(length),
  fee = ifelse(courses == max_workshops, week_price, courses*workshop_price))

# Approx hourly rate, not including no-shows and scholarships.
# This is manual
scholarships <- 120 + 60
(sum(res$fee)-scholarships)/(instructors*hours)
