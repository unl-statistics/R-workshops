## ----setup, include=FALSE------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)






## ---- production-echo, purl = T, echo = T, eval = F----
## production_data <- read.csv("https://unl-statistics.github.io/R-workshops/06-r-modeling/data/production.csv")
## head(production_data)










## ----condition-data-echo, echo = T, purl = T, eval = F----
## condition_data <- read.csv("https://unl-statistics.github.io/R-workshops/06-r-modeling/data/condition.csv")
## head(condition_data)






## ----datasets, purl = T, echo = T----------------------
data(package = .packages(all.available = TRUE))

