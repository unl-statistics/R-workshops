## ------------------------------------------------------
foo <- function(arg1, arg2, ...) {
    # Code goes here
    return(output)
}


## ------------------------------------------------------
mymean <- function(data) {
    ans <- sum(data) / length(data)
    return(ans)
}

set.seed(4) #to generate the same random numbers each time run sample function
example <- sample(1:200, 15) #return 15 random values between 1 and 200 without replacement. without set.seed, will return different values each time
mymean(example) #mean of random generated data


## ---- eval=FALSE---------------------------------------
## if (condition) {
##     # Some code that runs if condition is TRUE
## } else {
##     # Some code that runs if condition is FALSE
## }


## ------------------------------------------------------
x <- -4
if(x > 0){
print("Non-negative number")
} else {
print("Negative number")
}



## ------------------------------------------------------
mymean <- function(data) {
    if (!is.numeric(data)) {
        print("Numeric input is required")
    } else {
        ans <- sum(data) / length(data)
        return(ans)
    }
}

mymean("dog")
mymean(c(2,4,5,6,7))


## ------------------------------------------------------
for (i in 1:3) {
    print(i)
}


## ----message=FALSE, warning=FALSE----------------------

for(i in 1:5) {# Head of for-loop
  x1 <- i^2 # Code block
  print(x1) # Print results
}

final_shed <- read.csv("https://unl-statistics.github.io/R-workshops/01-r-intro/data/daily_shedding.csv")

id <- c("pig_weight", "total_shedding", "daily_shedding")
for(colname in id) {
    print(paste(colname, mymean(final_shed[, colname])))
}


## ------------------------------------------------------
i <- 1
while (i < 5) {
    print(i)
    i <- i + 1
}

