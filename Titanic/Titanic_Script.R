library(dplyr)

#load the file into a dataframe. Ensure strings are not factors so it causes us less type errors later
titanic <- tbl_df(read.csv("titanic3.csv", stringsAsFactors = FALSE))

#Add the has_cabin_number column to the df
titanic <- titanic %>% mutate(has_cabin_number="1")

#1: Port of embarkation. 
#Check for empty embarked data. Replace with 'S' if empty
titanic$embarked[titanic$embarked==""] <- 'S'

#2: Age
#2: Think about other ways you could have populated the missing values in the age column. Why would you pick any of those over the mean (or not)?
# For this set it seems that this may be the best way. Doing a comparision between age + fare, destination, embarked, ticket doesn't seem to show any patterns or trend. Age is independent of all of these factors.
#Check for empty age data. Replace with the mean of the ages.
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm=TRUE)

#3: Lifeboat
#Check if boat field is empty. Replace with 'NONE.' 
titanic$boat[titanic$boat==""] <- 'NONE'

#4: Cabin
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