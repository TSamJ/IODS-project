# Author: Tuomas Junna
#Date: 04.12.2023
# Data wrangling R script for IODS course assignment 5. 
#Origina data source : # Original data from: http://hdr.undp.org/en/content/human-development-index-hdi


library(readr)
library(tidyverse)
library(dplyr)

#Set working directory

setwd("C:/Users/tjunna/OneDrive - Valtori GTK/Desktop/R/IODS/IODS-project")

# Read in the Human Development dataset
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")

# Read in the Gender Inequality dataset
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Structure and dimensions of the Human Development dataset
str(hd)
dim(hd)

# Summaries of variables in the Human Development dataset
summary(hd)

# Structure and dimensions of the Gender Inequality dataset
str(gii)
dim(gii)


# Summaries of variables in the Gender Inequality dataset
summary(gii)

#Column names to console for renaming copypasta

colnames(hd)

colnames(gii)

#Rename some variables in GII

gii <- rename(gii, GII_rank = "GII Rank")
gii <- rename(gii, GII = "Gender Inequality Index (GII)")
gii <- rename(gii, matmort = "Maternal Mortality Ratio")
gii <- rename(gii, adobirth = "Adolescent Birth Rate")
gii <- rename(gii, parliF = "Percent Representation in Parliament")
gii <- rename(gii, eduF = "Population with Secondary Education (Female)")
gii <- rename(gii, eduM = "Population with Secondary Education (Male)")
gii <- rename(gii, labourF = "Labour Force Participation Rate (Female)")
gii <- rename(gii, labourM = "Labour Force Participation Rate (Male)")


#Rename in HD

hd <- rename(hd, HDI_rank = "HDI Rank")
hd <- rename(hd, HDI = "HID")
hd <- rename(hd, lifexpt = "Life Expectancy at Birth")
hd <- rename(hd, eduexpt = "Expected Years of Education")
hd <- rename(hd, meaneduyears = "Mean Years of Education")
hd <- rename(hd, GNI = "Gross National Income (GNI) per Capita")
hd <- rename(hd, GNI_HDI = "GNI per Capita Rank Minus HDI Rank")


# Mutate the "Gender Inequality" data
gii <- mutate(gii,
              ratio_edu = eduF / eduM,
              ratio_labour = labourF / labourM)

# Join the datasets using the Country variable (inner join)
human <- inner_join(hd, gii, by = "Country")

human <- human %>% 
  select(Country, ratio_edu, ratio_labour, eduexpt, lifexpt, GNI, matmort, adobirth, parliF)


#remove rows with missing values

human <- human[complete.cases(human), ]

#Remove rows that are not specific to a single country (regions)

human <- human[-c(156:162), ]

# Save the joined data to a CSV file in your data folder
write_csv(human, "data/human.csv")
