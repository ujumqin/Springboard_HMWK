library(dplyr)

#0: Load the data in RStudio

inventory <- tbl_df(read.csv("refine_original.csv"))

#add new columns and populate with temp data to be used later in code
inventory %>% mutate(product_category = product_code)
inventory %>% mutate(full_address = address)


#1: Clean up brand names

#rename company column to make it easier to work with
inventory = rename(inventory, company = ï..company, product = Product.code...number)

#First searches for words that start with p or f and end with  s.
#Second searches for words that start with ak, have a space, and end with either zo or z0.
#Third searches for words that start with u.
#Fourth searches for words that start with van, has a space, and has words after.
inventory$company <- gsub("\\w+ps$|\\w+fs$", "philips", inventory$company, ignore.case = TRUE)
inventory$company <- gsub("^ak\\s*zo$+|^ak\\s*z0$+", "akzo", inventory$company, ignore.case = TRUE)
inventory$company <- gsub("^u\\w+", "unilever", inventory$company, ignore.case = TRUE)
inventory$company <- gsub("^van\\s*\\w+", "van_houten", inventory$company, ignore.case = TRUE)


#2: Separate product code and number

#Create a new variable and split the product column into a list
split <- strsplit(as.character(inventory$product), split = "-")

#Puts the newly created split list and puts it into a dataframe
product_df <- setNames(do.call(rbind.data.frame,split), c("type", "code"))

#Takes the data from the new dataframe and puts it back into the original dataframe.
inventory <-inventory %>% mutate(product_code = product_df[,1]) %>%
  mutate(product_number = product_df[,2])


#3: Add product categories

#While loop to write device category column using product codes. 
x<-1
length(inventory$product_code)
while(x <= length(inventory$product_code)) {
  print(x)
  if(inventory$product_code[x] == 'p') {
    inventory$product_category[x] <-"Smartphone" 
    
  } else if(inventory$product_code[x] == 'v') {
    inventory$product_category[x] <-"TV" 
      
  } else if(inventory$product_code[x] == 'x') {
    inventory$product_category[x] <-"Laptop" 
      
  } else if(inventory$product_code[x] == 'q') {
    inventory$product_category[x] <-"Tablet"
  }
  x <- x+1
}


#4: Add full address for geocoding

#Code that concatenates address, city, and country into a full address.
x<-1
while(x <= length(inventory$address)) {
  print(x)
  inventory$full_address[x] <- (paste(inventory$address[x], inventory$city[x], inventory$country[x], sep=","))
  x <- x+1
}


#5: Create dummy variables for company and product category

#Creates new columns for coding.
inventory <- inventory %>% mutate("company_philips" = 0, "company_akzo" = 0, "company_van_houten" = 0, "company_unilever" = 0, "product_smartphone" = 0, "product_tv" = 0, "product_laptop" = 0, "product_tablet" = 0)

#Finds the company and codes it accordingly
inventory$company_philips[inventory$company %in% "philips"] <-1
inventory$company_akzo[inventory$company %in% "akzo"] <-1
inventory$company_van_houten[inventory$company %in% "van_houten"] <-1
inventory$company_unilever[inventory$company %in% "unilever"] <-1

#Finds the product and codes it accordingly
inventory$product_smartphone[inventory$product_category %in% "Smartphone"] <-1
inventory$product_tv[inventory$product_category %in% "TV"] <-1
inventory$product_tablet[inventory$product_category %in% "Tablet"] <-1
inventory$product_laptop[inventory$product_category %in% "Laptop"] <-1


#Rearranges the columns and drops the original product column
inventory <- inventory[,c("company","product_code","product_number","product_category","full_address","name","company_philips", "company_akzo", "company_van_houten", "company_unilever", "product_smartphone", "product_tablet", "product_tv", "product_laptop" )]

write.csv(inventory, file = "refine_clean.csv")
