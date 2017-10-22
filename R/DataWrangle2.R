#Data Wrangle excercise-1

#load packages
library(readxl)

library(tidyr)
library(dplyr)
library(dummies)

#load raw data from ~/data , save the data set as a CSV file called refine_original.csv and load it

rawdata.xls <- "data/titanic3.xls"
rawdata.csv <- "data/titanic3_original.csv"
refine <- read_excel(rawdata.xls)
refine %>% data.table::fwrite(rawdata.csv)
View(refine)
titanic.refine <- read.csv(rawdata.csv)

#titanic.refine %>% filter(!embarked  %in% c("C","Q","S")) %>% select(embarked) %>% distinct(embarked) %>% as.vector()
# set to S for missing embarked
titanic.refine <- titanic.refine %>% mutate(embarked = replace(embarked, embarked != "S" & embarked != "C" & embarked != "Q" , "S" ))
# validate that there are no missed embarked 
embarked.invalid.cnt <- titanic.refine %>% filter(!embarked  %in% c("C","Q","S")) %>% select(embarked) %>% summarise(n= n()) %>% as.integer()

#Age set the missing age
average <- mean(titanic.refine$age, na.rm = TRUE)
titanic.refine <- titanic.refine %>% mutate(age = replace(age,is.na(age),average))

#Fill the lifeboat with NA for empty value of boat column
titanic.refine <- titanic.refine %>% mutate(boat=replace(boat,boat == "",NA))

# add cnew column has_cabin_number with 1 when cabin column is not empty otherwise set to 0
titanic.refine <- titanic.refine %>% mutate( has_cabin_number = ifelse(.$cabin == "",0,1))

#write the cleaned file to refine_clean
write.csv(titanic.refine,file = "data/titanic_clean.csv")