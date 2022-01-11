library(tidyverse)

# List all slide Rmd files
input <- list.files(pattern = "*.Rmd", full.names = T, recursive = T)
input <- input[str_detect(input, "knitr")]

# Location to put the code files
output <- str_replace(input, "/knitr/", "/code/") %>%
  str_replace("\\.Rmd", ".R")

# Run through everything with purl
purrr::map2(input, output, knitr::purl)
