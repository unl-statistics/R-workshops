library(tidyverse)

# copy README to index
file.copy("README.qmd", "index.qmd", overwrite = T)

# List all slide Rmd files
input <- list.files(pattern = "*.(q|R)md", full.names = T, recursive = T)
input <- input[str_detect(input, "knitr|index|README")]
input <- input[!str_detect(input, "Old|summerschool")]



# Location to put the code files
r_output <- str_replace(input, "/knitr/", "/code/") %>%
  str_replace("\\.(R|q)md", ".R")

html_output <- str_replace(input, "(q|R)md$", "html")

# Run through all the markdown files and compile
purrr::walk(input, ~rmarkdown::render(.))

# Run through everything with purl
purrr::map2(input, r_output, knitr::purl)
