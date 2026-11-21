# Day 1: Project Setup & Data Import
# Task 2: Environment Setup & Data Import

# Loads necessary libraries
library(tidyverse)

# Import dataset 
nhis_raw <- read.csv("NHIS _Data_2021.csv")

# Initial Exploration
print("Dataset Structure:")
str(nhis_raw)

print("Statistical Summary:")
summary(nhis_raw)

print("First 6 Rows:")
head(nhis_raw)