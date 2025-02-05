## ----eval = TRUE--------------------------------------------------------------
# Creating a matrix (3x3)
row_matrix <-  matrix(
  # Taking sequence of elements 
  c(1, 2, 3, 4, 5, 6, 7, 8, 9),
  # Number of rows
  nrow = 3,  
  # No. of columns
  ncol = 3,        
  # By default matrices are in column-wise order
  # So this parameter decides how to arrange the matrix
  byrow = TRUE         
)

row_matrix



## -----------------------------------------------------------------------------
# Naming rows
rownames(row_matrix) = c("r1", "r2", "r3")
  
# Naming columns
colnames(row_matrix) = c("c1", "c2", "c3")

row_matrix



## -----------------------------------------------------------------------------
#matrix[row,col]

row_matrix[1,]
row_matrix[,1]
row_matrix[c(1,3),2]




## -----------------------------------------------------------------------------
A <- matrix(c(1, 2, 3, 4), ncol=2)
A
B <- matrix(c(5, 6, 7, 8), ncol=2) #would print out similarily

A%*%B
# Note * does element by element multiplication

t(A) #transpose of A




## ----echo=FALSE---------------------------------------------------------------

matrix(c(2,4,6,8,10,12), nrow=3, ncol = 2, byrow = FALSE)



## -----------------------------------------------------------------------------
flower <- iris

head(flower)


## -----------------------------------------------------------------------------
flower[,5]


## -----------------------------------------------------------------------------
flower$Species


## -----------------------------------------------------------------------------
flower$Species == "setosa"


## -----------------------------------------------------------------------------
flower[flower$Species=="setosa", ]


## -----------------------------------------------------------------------------

two_sepal_width <- flower$Sepal.Width * 2

flower_new <- data.frame(flower,two_sepal_width)

head(flower_new, n=3)

ncol(flower)
ncol(flower_new)
  
  


## ----message=FALSE, warning=FALSE---------------------------------------------
library(tidyverse)

mydf <- data_frame(NUMS = 1:5, 
                   lets = letters[1:5],
                   vehicle = c("car", "boat", "car", "car", "boat"))
mydf


## -----------------------------------------------------------------------------
names(mydf)[1]<- ("nums")
mydf


## -----------------------------------------------------------------------------
mylist <- list(matrix(letters[1:10], nrow = 2, ncol = 5),
               seq(0, 49, by = 7))
mylist


## -----------------------------------------------------------------------------
mylist[[2]]


## -----------------------------------------------------------------------------
head(iris, n = 2)


## -----------------------------------------------------------------------------
str(iris)


## -----------------------------------------------------------------------------
t.test(Petal.Length ~ Species, data = iris[iris$Species != "virginica", ])


## -----------------------------------------------------------------------------
tout <- t.test(Petal.Length ~ Species, data = iris[iris$Species != "virginica", ])


## -----------------------------------------------------------------------------
str(tout)


## -----------------------------------------------------------------------------
#pvalue
tout$p.value
tout[[3]]



## ----eval=FALSE---------------------------------------------------------------
## # df = iris[1:10, 1:5]
## # write.csv(df, 'tips.csv')
## 
## littledata <- read.csv("tips.csv", header = TRUE)
## 
## head(littledata)

