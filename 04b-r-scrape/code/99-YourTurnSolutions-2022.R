## Your Turn Intro
#Example from class
url <- "http://www.baseball-reference.com/players/a/"
html <- read_html(url)
html %>% html_nodes("strong a") %>% html_text()

## Your Turn HTML Tables
library(rvest)
library(magrittr)
#This one is done with data that they select on their own
  
## Your Turn JSON 
library(jsonlite)
workshop_commits_raw <- fromJSON("https://api.github.com/repos/heike/rwrks/commits") 
#Try finding a different github profile and run the script

# 2. Find the table of commits contained in this list

commits <- workshop_commits_raw$commit$committer

# 3. Plot the total number of commits (number of rows) by user as a bar chart

library(ggplot2)
qplot(commits$name)
