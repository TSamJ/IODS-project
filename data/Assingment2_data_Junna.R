#IODS Assingment 2 Data wrangling exercise
#Author: Tuomas Junna
#Date: 06.11.2023


#Libraries for wrangling, tidyverse and dplyr

library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)

#Set working directory

setwd("C:/Users/tjunna/OneDrive - Valtori GTK/Desktop/R/IODS/IODS-project")

#Read tab delimited txt as df

df <- read.delim("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = TRUE, sep = "\t")

#Check what it looks like

head(df, 10)

#Check the structure

str(df)

#All integers, apart from gender as characters

# Check for missing values

is.na(df)

#Check dimensions

dim(df)

# 183 rows in 60 columns. Although this was evident looking at the environment window.

#Check the names of the headers

names(df)

#Mostly gibberish apart from Age, Attitude, Points and gender. Let's check the amount
#genders

n_distinct(df$gender)

# 2. Pretty vanilla. 

#Ok a summary of it all then

summary(df)

#Small values in most. Normally, I would assume normalized data but more likely
#questinnoire data Age, attitude and points being the difference. Age is self explanatory, 
#two other could be sums of other values.

# create column 'attitude' by scaling the column "Attitude"
df <- df %>% 
  mutate(attitude = (Attitude /10))

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(df, one_of(deep_questions))
# and create column 'deep' by averaging
df$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(df, one_of(surface_questions))
# and create column 'surf' by averaging
df$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(df, one_of(strategic_questions))
# and create column 'stra' by averaging
df$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning_2014 <- select(df, "gender","Age","attitude", "deep", "stra", "surf", "Points")

# print out the column names of the data
colnames(learning_2014)

# change the name of the second column
colnames(learning_2014)[2] <- "age"

# change the name of "Points" to "points"

colnames(learning_2014)[7] <- "points"


# print out the new column names of the data

names(learning_2014)

# select male students
male_students <- filter(learning_2014, gender == "M")

# select rows where points is greater than zero
learning_2014 <- filter(learning_2014, points > 0)

#Write the data file
write_csv(learning_2014, file = "data/learning_2014.csv")

#Load in the created data frame to test functionality
df_test <- read_csv("data/learning_2014.csv")

str(df_test)

head(df_test)


