#Data Wrangle excercise-1

#load packages
library(readxl)
#library(gdata)  
library(tidyr)
library(dplyr)
library(dummies)

#load raw data from ~/data , save the data set as a CSV file called refine_original.csv and load it
setwd(paste(getwd(),"/data/", sep=""))
rawdata.xls <- "refine.xlsx"
rawdata.csv <- "refine_original.csv"
refine <- read_excel(rawdata.xls)
View(refine)
refine %>% data.table::fwrite(rawdata.csv)
dframe <- read.csv(rawdata.csv)

# transform the values in the company column to be lowercase
dframe$company <- tolower(dframe$company)

# cleanup brand name  look at unique company values for each fil,phi,lips filter(dframe, grepl('phi', company)) %>% distinct(company)
# verify that all company names cleanedup by looking at data from dframe %>% distinct(company) 
dframe$company <- gsub("phillips|phillps|phllips|fillips|phlips","philips",dframe$company)
dframe$company <- gsub("unilver","unilever",dframe$company)
dframe$company <- gsub("akz0|ak zo","akzo",dframe$company)
  
# Separate product code and number
dframe <- separate(dframe, "Product.code...number", c("prodcode","prodnum"), sep = "-")

# Add product categeories
dframe <- mutate(dframe, prod.categories = prodcode)
dframe$prod.categories <- sub("p", "Smartphone", dframe$prod.categories)
dframe$prod.categories <- sub("v", "TV", dframe$prod.categories)
dframe$prod.categories <- sub("x", "Laptop", dframe$prod.categories)
dframe$prod.categories <- sub("q", "Tablet", dframe$prod.categories)

#Add full address for geocoding
dframe <- unite(dframe,full_address,address,city,country,sep=",")

#create dummy varibale for company , product categeory
dframe <- dummy.data.frame(dframe, dummy.class = "binary", names = "company", sep = "_")
dframe <- dummy.data.frame(dframe, dummy.class = "binary", names = "prod.categories", sep = "_")
