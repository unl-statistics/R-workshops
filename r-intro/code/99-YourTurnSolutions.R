## -----------------------------------------------------------------------------

#shed <- read_csv("https://unl-statistics.github.io/R-workshops/01-r-intro/data/daily_shedding.csv")

shed <- read.csv("../data/daily_shedding.csv")


summary(shed$daily_shedding)


## ----message=FALSE------------------------------------------------------------
library(tidyverse)

final_shed <- shed %>% 
  group_by(pignum) %>% 
  mutate(gain = pig_weight[time_point == 21] - pig_weight[time_point == 0]) %>% filter(time_point == 21)  %>% ungroup() %>% select(-c(4:9))

ggplot(final_shed) + 
  geom_boxplot( aes(treatment, gain, fill = treatment))


## -----------------------------------------------------------------------------
wilcox.test(total_shedding ~ treatment, data = final_shed,
            subset = treatment %in% c("control", "Bglu"))


## -----------------------------------------------------------------------------
nrow(iris)
ncol(iris)
dim(iris)


## -----------------------------------------------------------------------------
rep(1:5, each = 2)


## -----------------------------------------------------------------------------
rep(1:5, times = 3)


## -----------------------------------------------------------------------------
sum(c(TRUE, TRUE, FALSE, TRUE, FALSE))


## -----------------------------------------------------------------------------
sum(shed$total_shedding < .30)


## -----------------------------------------------------------------------------
sum(shed$total_shedding[shed$total_shedding < 30])


## -----------------------------------------------------------------------------
shedding <- final_shed$total_shedding
treatment <- final_shed$treatment
id <- (shedding <= 30 | treatment == "Acid")
final_shed[id,]


## -----------------------------------------------------------------------------
matrix(
  c(1, 2, 3, 4, 5, 6, 7, 8, 9),
  nrow = 3,  
  ncol = 3,        
  byrow = FALSE        
)


## -----------------------------------------------------------------------------
matrix(c(2,4,6,8,10,12), nrow=3, ncol = 2, byrow = FALSE)


## -----------------------------------------------------------------------------
mydf <- data.frame(col1 = 1:6, col2 = rep(c("a", "b"), times = 3))


## -----------------------------------------------------------------------------
mydf[mydf$col2 == "a",]


## -----------------------------------------------------------------------------
names(mydf) <- c("Bulldogs", "Tigers")


## -----------------------------------------------------------------------------
mtcars[4,]


## -----------------------------------------------------------------------------
flower <- iris

total <- flower$Sepal.Length + flower$Sepal.Width + flower$Petal.Length + flower$Petal.Width

flower2 <- data.frame(flower, total)

head(flower2)



## -----------------------------------------------------------------------------
flower_s <- flower[flower$Sepal.Length>6, ]

total_s <- flower_s$Sepal.Length + flower_s$Sepal.Width

head(data.frame(flower_s, total_s))



## -----------------------------------------------------------------------------
mylist <- list(vec = 1:6, df = data.frame(x = 1:2, y = 3:4, z = 5:6))


## -----------------------------------------------------------------------------
mylist[[2]]


## -----------------------------------------------------------------------------
mylist[[2]][1,]


## -----------------------------------------------------------------------------
head(mtcars, n = 8)


## -----------------------------------------------------------------------------
str(mtcars)


## -----------------------------------------------------------------------------
dim(iris)


## -----------------------------------------------------------------------------
summary(iris)


## -----------------------------------------------------------------------------
mean_and_ci <- function(x) {
    themean <- mean(x)
    theci <- t.test(x)$conf.int
    
    return(list(mean = themean, ci = theci))
}


## -----------------------------------------------------------------------------
mean_and_ci <- function(x) {
    if (!is.numeric(x) && !is.logical(x)) stop("Need logical or numeric data")
    
    x <- as.numeric(x)
    
    themean <- mean(x)
    theci <- t.test(x)$conf.int
    
    return(list(mean = themean, ci = theci))
}


## -----------------------------------------------------------------------------
for (i in colnames(diamonds)) {
  if (is.numeric(diamonds[,i,drop = TRUE])) {print(mean_and_ci(diamonds[,i,drop = TRUE]))}
  else {print("nope")}
}

