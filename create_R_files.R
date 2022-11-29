library(tidyverse)

# copy README to index
file.copy("README.qmd", "index.qmd", overwrite = T)

# List all slide Rmd files
input <- list.files(pattern = "*.(q|R)md", full.names = T, recursive = T)
index <- input[str_detect(input, "index|README")]
knitr <- input[str_detect(input, "knitr")]
knitr <- input[!str_detect(knitr, "Old|summerschool")]



# Location to put the code files
r_output <- str_replace(knitr, "/knitr/", "/code/") %>%
  str_replace("\\.(R|q)md", ".R")

# Run through all the markdown files and compile
purrr::walk(knitr, ~rmarkdown::render(.))
purrr::walk(index, rmarkdown::render)


# Run through everything with purl
purrr::map2(knitr, r_output, knitr::purl)
