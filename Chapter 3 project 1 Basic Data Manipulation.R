install.packages("tidyverse")
library(readr)
library(dplyr)
library(tidyr)
refine_original <- read_csv("refine_original.csv")
View(refine_original)
#I tried to replace refine_original with my_df at the top and it did
#not work for some reason so I am doing this. 

my_df <- refine_original

#Getting rid of the extra rows. I do not know why the extra rows 
#were there in the first place

my_df <- my_df[1:25, ]
head(my_df)
 tolower(my_df$company)
 
my_df[1:6, 1] <-  "philips"
my_df[7:13, 1] <- "akzo"
my_df[14:16, 1] <- "philips"
my_df[17:21, 1] <- "van houten"
my_df[22:25, 1] <- "unilever"
# I also have no idea why the original data frame has 999 observations

#separating second column into 2 columns.I spent an embarrasing amount
#of time trying to make other funcitons work before typing "r one column
#into two" and finding the separate command.  
my_df2 <- my_df %>%separate(2, c("product_code", "product_number"), sep = "-")
head(my_df)
summary(my_df)



#Making the product category column
my_df2$product_category <- codenames[my_df2$product_code]
head(my_df2)

#created third data frame when creating address column and removing inputs,
# I also added a space to the sep because I thought it would look better
my_df3 <- my_df2 %>% unite("full_address", address, city, country, sep = ", ")

# I was getting issues putting a dataframe into mutate so I made it a tibble
#because I saw Hadley Wickham do it on his website
my_df4 <- my_df3 %>% as_tibble() 

# I just used mutate to add in every column name and just made them equal 1
#I tried to make a variable with a list of names using c() but I couldn't
#get it to work 

my_df5 <- my_df4 %>% mutate(my_df4$company, "company_philips" = 1, 
                            "company_akzo" = 1,
                            "company_van_houten" =1, 
                            "company_unilever" = 1,
                            "product_smartphone" = 1, 
                            "product_tv" =1, 
                            "product_laptop" =1, 
                            "product_tablet"= 1)

#The above method has the side effect of creating a column called 
#my_df$company.  I figured just finding the column number and removing it
#was the easiest solution. 
final_df <- my_df5[, -7]

#writing final CSV
write.csv(final_df, "refine_clean.csv")