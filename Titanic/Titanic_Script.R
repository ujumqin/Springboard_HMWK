library(dplyr)
options(max.print = 100000)

#load the file into a dataframe. Ensure strings are not factors so it causes us less type errors later
titanic <- tbl_df(read.csv("titanic3.csv", stringsAsFactors = FALSE))

#Add the has_cabin_number column to the df
titanic <- titanic %>% mutate(has_cabin_number="1")

#Check for empty embarked data. Replace with 'S' if empty
titanic$embarked[titanic$embarked==""] <- 'S'
print(titanic$embarked)

#Check for empty age data. Replace with the mean of the ages.
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm=TRUE)
print(titanic$age)

#Check if boat field is empty. Replace with 'NONE.' 
titanic$boat[titanic$boat==""] <- 'NONE'
print(titanic$boat)


#while loop to check whether there is a value in the cabin field. If none, add zero, else add 1
x <-1
while(x <= length(titanic$cabin)){
  if(titanic$cabin[x] == "") {
    titanic$has_cabin_number[x] = 0
    x<-x+1
} else {
  titanic$has_cabin_number[x] = 1
  x<-x+1
}
}
write.csv(titanic, file = "titanic_clean.csv")
