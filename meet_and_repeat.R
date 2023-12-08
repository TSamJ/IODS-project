# Author: Tuomas Junna
#Date: 08.12.2023
# Data wrangling R script for IODS course assignment 6. 
#Origina data source : # Original data from: http://hdr.undp.org/en/content/human-development-index-hdi


library(readr)
library(tidyverse)
library(dplyr)

#Set working directory

setwd("C:/Users/tjunna/OneDrive - Valtori GTK/Desktop/R/IODS/IODS-project")

#Read datasets

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Factor treatment & subject BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form BPRS
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks, 5,5)))

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert data to long form
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD,3,4))) %>%
  arrange(Time)

# Glimpse the data
glimpse(RATSL)

glimpse(BPRSL)

#Explore dataframes

str(RATS)
dim(RATS)
names(RATS)

str(RATSL)
dim(RATSL)
names(RATSL)
