# Author: Tuomas Junna
#Date: 14.11.2023
# Data wrangling R script for IODS course assignment 3. 
#Data source : http://www.archive.ics.uci.edu/dataset/320/student+performance

#Libraries

library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)

# Set the working directory 
setwd("C:/Users/tjunna/OneDrive - Valtori GTK/Desktop/R/IODS/IODS-project")

# Read the CSV files into a data frames
df_mat <- read.csv("data/student-mat.csv", sep = ";", header=TRUE)
df_por <- read.csv("data/student-por.csv", sep = ";", header=TRUE)

# View the first few rows of the data frames

head(df_mat)
head(df_por)

#Check the structure

str(df_mat)
str(df_por)

#Check dimensions

dim(df_mat)
dim(df_por)

#Column names

colnames(df_mat)
colnames(df_por)

# give the columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(df_por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(df_mat, df_por, by = join_cols)

# look at the column names of the joined data set
names(math_por)

# glimpse at the joined data set
glimpse(math_por)

# create a new data frame with the joined columns

alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}

#Create a new column for people who consumer alcohol more often

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#Check it 

glimpse(alc)


