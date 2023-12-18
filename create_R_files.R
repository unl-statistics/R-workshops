library(tidyverse)

# copy README to index
#file.copy("README.qmd", "index.qmd", overwrite = T)

# List all slide Rmd files
input <- list.files(pattern = "*.(q|R)md", full.names = T, recursive = T)
index <- input[str_detect(input, "index|README")]
slides <- input[str_detect(input, "slides")]
slides <- slides[!str_detect(slides, "Old|summerschool")]

# Exclude scrape/shiny for now
slides <- slides[!str_detect(slides, "scrape|shiny")]



# Location to put the code files
r_output <- str_replace(slides, "/slides/", "/code/") %>%
  str_replace("\\.(R|q)md", ".R")

# Run through all the markdown files and compile
# purrr::walk(slides, ~rmarkdown::render(.))
# purrr::walk(index, rmarkdown::render)


# Run through everything with purl
purrr::map2(slides, r_output, knitr::purl)
