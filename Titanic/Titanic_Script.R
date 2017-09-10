library(dplyr)
options(max.print = 100000)

titanic <- tbl_df(read.csv("titanic3.csv", stringsAsFactors = FALSE))

titanic$embarked[titanic$embarked==""] <- 'S'
print(titanic$embarked)

titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm=TRUE)
print(titanic$age)

titanic$boat[titanic$boat==""] <- 'NONE'
print(titanic$boat)





print(titanic)


titanic$age[16] == NA
typeof(titanic$age)
print(titanic$age)
mean(titanic$age, na.rm = TRUE)

?mean

if(titanic$boat[3] == "") {
  print("This is true")
} else {
  print("This is false")
}

