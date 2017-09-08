library(dplyr)
options(max.print = 100000)

titanic <- tbl_df(read.csv("titanic3.csv"))

titanic$embarked[titanic$embarked==""] <- 'S'
print(titanic$embarked)

titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm=TRUE)
print(titanic$age)




print(titanic)


titanic$age[16] == NA
typeof(titanic$age)
print(titanic$age)
mean(titanic$age, na.rm = TRUE)

?mean

if(titanic$age[16] == TRUE) {
  print("This is true")
} else {
  print("This is false")
}


if(is.na(titanic$age[16])) {
  print("This is na")
} else {
  print("Something Else")
}


